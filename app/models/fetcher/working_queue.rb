module Fetcher
  class WorkingQueue
    attr_reader :redis, :working_queue_name

    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      @redis              = args[:redis]
      @working_queue_name = args[:working_queue_name]
    end

    def perform
      return true if redis.llen(working_queue_name) > 0
      false
    end
  end
end
