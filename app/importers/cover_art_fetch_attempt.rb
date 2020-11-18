# frozen_string_literal: true

# Single fetch attempt to coverartarchive.org
class CoverArtFetchAttempt < ServiceBase
  FATAL_STATUS = [400, 405, 406, 503].freeze

  # rubocop:disable Lint/MissingSuper
  def initialize(import_request:)
    # super
    @import_request = import_request
  end
  # rubocop:enable Lint/MissingSuper

  def call
    import_request.attempts.create!(message: response.reason_phrase, status_code: status)

    case status
    when 200
      Rails.logger.info("Succesful fetched #{url}")
      return response
    when 404
      Rails.logger.info("404 #{url} not found")
      return response
    end

    on_error
  end

  attr_reader :import_request

  private

  def on_error
    message = case status
              when 400
                "400 #{url} contains no valid UUID"
              when 503
                "503 #{url} User has exeted rate limit"
              else
                "can't fetch #{url} status #{status}"
              end

    raise ImportError::CanNotFetch, message if fatal?

    Rails.logger.warn(message)
  end

  def faraday_connection
    Faraday.new do |connection|
      connection.use FaradayMiddleware::FollowRedirects, limit: 5
      connection.adapter Faraday.default_adapter
    end
  end

  def fatal?
    FATAL_STATUS.include?(status)
  end

  def response
    @response ||= faraday_connection.get(url)
  end

  def status
    response.status
  end

  def url
    import_request.to_uri
  end
end
