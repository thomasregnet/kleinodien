# frozen_string_literal: true

# Subscribe to a Redis pub/sub channel and return received messages
class ImportSubscriber
  def initialize(args)
    @channel   = args[:channel]
    @timeout   = args.fetch(:timeout, 300)
  end

  attr_reader :channel, :timeout

  def perform
    begin
      redis.subscribe_with_timeout(timeout, channel) do |on|
        on.message do |_, message|
          unsubscribe
          return message
        end
      end
    rescue Redis::TimeoutError => exception
      Rails.logger.info("#{exception.class}: #{exception}")
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
