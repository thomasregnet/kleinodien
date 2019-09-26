# frozen_string_literal: true

# Subscribe to a Redis pub/sub channel and return received messages
class ImportSubscriber
  def initialize(args)
    @channel   = args[:channel]
    @timeout   = args.fetch(:timeout, 300)
  end

  attr_reader :channel, :timeout

  def perform
    redis.subscribe_with_timeout(timeout, channel) do |message_obj|
      handle_message(message_obj)
    end
  rescue Redis::TimeoutError => exception
    Rails.logger.info("#{exception.class}: #{exception}")
  end

  private

  def handle_message(message_obj)
    message_obj.message do |_, message|
      Rails.logger("received #{message} on channel #{channel}")
      unsubscribe
      message
    end
  end

  def redis
    REDIS
  end

  def unsubscribe
    Rails.logger('unsubscribe')
    redis.unsubscribe(channel)
  end
end
