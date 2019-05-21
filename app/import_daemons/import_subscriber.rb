# frozen_string_literal: true

# Subscribe to a Redis pub/sub channel and return received messages
class ImportSubscriber
  def initialize(args)
    @channel   = args[:channel]
    @redis_url = args[:redis_url]
    @timeout   = args[:timeout]
  end

  def perform
    redis.subscribe_with_timeout(timeout, channel) do |on|
      on.message do |_, message|
        unsubscribe
        return message
      end
    end
  end

  def redis
    @redis ||= Redis.new(url: redis_url)
  end

  def unsubscribe
    redis.unsubscribe(channel)
  end
end
