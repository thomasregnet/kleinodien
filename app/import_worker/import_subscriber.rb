# frozen_string_literal: true

# Subscribe to a Redis pub/sub channel and return received messages
class ImportSubscriber
  def initialize(channel:, timeout: 300)
    @channel   = channel
    @timeout   = timeout
  end

  attr_reader :channel, :timeout

  def perform
    redis.subscribe_with_timeout(timeout, channel) do |message_obj|
      handle_message(message_obj)
    end
  rescue Redis::TimeoutError => e
    Rails.logger.info("#{e.class}: #{e}")
  end

  private

  def handle_message(message_obj)
    message_obj.message do |_, message|
      Rails.logger.info("received #{message} on channel #{channel}")
      unsubscribe
      message
    end
  end

  def redis
    REDIS
  end

  def unsubscribe
    Rails.logger.info("unsubscribing from #{channel}")
    redis.unsubscribe(channel)
  end
end
