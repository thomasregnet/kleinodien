module Fetcher
  # Coordinate fetching
  class Queue
    # TODO: Fetcher::Queue is only a draft, stimulate it!
    attr_reader :fetcher_name, :redis
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      @fetcher_name = args[:fetcher_name]
      @redis        = args[:redis]
    end

    def perform
      # perform_working_queues()
      # perform_waiting_queues()
    end

    def perform_working_queues
      # WorkingQueue.perform()
    end

    def perform_waiting_queues
    end
  end
end
