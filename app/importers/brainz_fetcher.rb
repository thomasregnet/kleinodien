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
    start_processing
    fetch

    done_processing
    BrainzBlueprint.from_xml(response.body)
  end

  def start_processing
    import_request.processing
    import_request.save!
  end

  def done_processing
    import_request.done
    import_request.save!
  end

  def fetch
    max_tries.times do
      take_a_nap
      # @response = Faraday.get(uri)
      fetch_attempt
      return response if good_response?
    end

    raise ImportError::CanNotFetch, "can not fetch data from #{uri}"
  end

  def uri
    import_request.to_uri
  end

  def fetch_attempt
    respone = Faraday.get(uri)
    status_code = respone.status
    attemt = import_request.attempts.new(status_code: status_code)
    attemt.message = respone.body unless status_code == 200
    attemt.save!

    respone
  end

  # TODO: make max_tries configurable
  def max_tries
    3
  end

  def good_response?
    return false unless response
    return true if response.status == 200

    false
  end

  def take_a_nap
    # TODO: implement take_a_nap
  end
end
