# frozen_string_literal: true

# Fetch data from coverartarchive.org
class CoverArtFetcher
  DEFAULT_MAX_TRIES = 5

  def self.call(*args)
    new(*args).call
  end

  def initialize(import_request:)
    @import_request = import_request
  end

  attr_reader :import_request

  def call
    import_request.run

    fetch
  end

  private

  def attempt
    Rails.logger.info("Trying to get #{uri}")
    response = Faraday.get(uri)
    import_request.attempts.create!(message: response.reason_phrase, status_code: response.status)
    response
  end

  def fetch
    max_tries.times do |nap_time|
      sleep(nap_time)
      response = attempt
      if response.success?
        on_success
        return response
      end
    end

    on_error
  end

  def max_tries
    DEFAULT_MAX_TRIES
  end

  def on_error
    Rails.logger.error("Failed to get #{uri}")
    import_request.failure!
    raise ImportError::CanNotFetch, "can't fetch data from #{uri}"
  end

  def on_success
    Rails.logger.info("Succesful fetched #{uri}")
    import_request.done!
  end

  def uri
    import_request.uri
  end
end
