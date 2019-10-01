# frozen_string_literal: true

# Fetch data from the MusicBrainz web-service
class BrainzFetcher
  def self.call(args)
    new(args).call
  end

  def initialize(import_request:)
    @import_request = import_request

    @interrupter = BrainzImportInterrupter.instance
  end

  attr_reader :import_request, :interrupter

  def call
    import_request.run
    response = fetch

    import_request.done
    BrainzBlueprint.from_xml(response.body)
  end

  def fetch
    max_tries.times do
      response = fetch_attempt
      if response.success?
        save_response_body(response)
        return response
      end
    end

    can_not_fetch
  end

  def can_not_fetch
    import_request.failure
    raise ImportError::CanNotFetch, "can not fetch data from #{uri}"
  end

  def uri
    import_request.to_uri
  end

  def fetch_attempt
    take_a_nap
    response = Faraday.get(uri)
    import_request.attempts.create!(
      message:     response.reason_phrase,
      status_code: response.status
    )
    response.success? ? interrupter.signal_success : interrupter.signal_error

    response
  end

  # TODO: make max_tries configurable
  def max_tries
    5 # 3
  end

  def save_response_body(response)
    # TODO: Make saving a ImportRequest#body optional per configuration
    import_request.create_body!(content: response.body)
  end

  def take_a_nap
    interrupter.perform
  end
end
