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
    max_tries.times do |nap_time|
      sleep(nap_time)
      Rails.logger.info("trying to fetch image form #{import_request.uri}")
      response = CoverArtFetchAttempt.call(import_request: import_request)
      status = response.status
      return response if status == 200
      return nil if status == 404
    end

    raise ImportError::CanNotFetch
  end

  def max_tries
    DEFAULT_MAX_TRIES
  end
end
