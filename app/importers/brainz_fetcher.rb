# frozen_string_literal: true

# Fetch data from the MusicBrainz web-service
class BrainzFetcher
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_request = args[:import_request]
  end

  attr_reader :import_request, :response

  def call
    change_import_request_status_to(:processing)
    fetch
    change_import_request_status_to(:done)
    BrainzBlueprint.from_xml(response.body)
  end

  def change_import_request_status_to(status)
    import_request.send status
    import_request.save!
  end

  def fetch
    max_tries.times do
      take_a_nap
      fetch_attempt
      if response.success?
        save_response_body
        return
      end
    end

    can_not_fetch
  end

  def can_not_fetch
    change_import_request_status_to(:failed)
    raise ImportError::CanNotFetch, "can not fetch data from #{uri}"
  end

  def uri
    import_request.to_uri
  end

  def fetch_attempt
    @response = Faraday.get(uri)
    status_code = response.status
    attemt = import_request.attempts.build(status_code: status_code)
    attemt.message = response.body unless response.success?
    attemt.save!
  end

  # TODO: make max_tries configurable
  def max_tries
    3
  end

  def save_response_body
    # TODO: Make saving a ImportRequest#body optional per configuration
    import_request.create_body!(content: response.body)
  end

  def take_a_nap
    # TODO: implement take_a_nap
  end
end
