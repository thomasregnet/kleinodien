module Importer
  # Coordinate fetching
  module Queue
    class Queue
      # TODO: Importer::Queue::Queue is only a draft, stimulate it!
      # TODO: Importer::Queue::Queue is a stupid name, change it!
      attr_reader :fetcher_name, :redis
      def self.perform(args)
        new(args).perform
      end

      def initialize(args)
        @fetcher_name = args[:fetcher_name]
        @redis        = ImporterConnection.redis
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
end
