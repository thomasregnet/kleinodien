# frozen_string_literal: true

# Fetch data from the MusicBrainz web-service
class BrainzFetcher
  def self.call(args)
    new(**args).call
  end

  def initialize(import_request:)
    @import_request = import_request

    @interrupter = BrainzImportInterrupter.instance
  end

  attr_reader :import_request, :interrupter, :response

  def call
    import_request.run
    response = fetch

    # import_request.done
    BrainzBlueprint.from_xml(response.body)
  end

  def fetch
    max_tries.times do
      fetch_attempt
      return success if response.success?
    end

    fetch_failed
  end

  def fetch_attempt
    take_a_nap
    Rails.logger.info("Trying to get #{uri}")
    @response = Faraday.get(uri)
    create_attempt
    response.success? ? interrupter.signal_success : interrupter.signal_error
  end

  # TODO: make max_tries configurable
  def max_tries
    5 # 3
  end

  private

  def create_attempt
    import_request.attempts.create!(
      message:     response.reason_phrase,
      status_code: response.status
    )
  end

  def fetch_failed
    Rails.logger.error("Failed to get #{uri}")
    import_request.failure!
    raise ImportError::CanNotFetch, "can not fetch data from #{uri}"
  end

  def save_response_body
    # TODO: Make saving a ImportRequest#body optional per configuration
    import_request.create_body!(content: response.body)
  end

  def success
    save_response_body
    import_request.done!

    response
  end

  def take_a_nap
    interrupter.perform
  end

  def uri
    import_request.to_uri
  end
end
