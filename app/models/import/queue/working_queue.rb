module Import
  module Queue
    class WorkingQueue < ::Import::Queue::Base
      attr_reader :getter_class, :redis, :working_queue_name

      def self.perform(args)
        new(args).perform
      end

      def initialize(args)
        @getter_class       = args[:getter_class]
        @redis              = ImportConnection.redis
        @working_queue_name = args[:working_queue_name]

        super(args)
      end

      def perform
        return false unless redis.llen(working_queue_name).positive?
        retrieve_and_store
      end

      private

      def retrieve_and_store
        uri = redis.lindex(working_queue_name, 0)
        # TODO: error handling
        data = getter_class.perform(uri)
        store_data(data, uri)
      end

      def store_data(data, uri)
        key = conventions.key_name_for(uri)
        redis.multi do |multi| # transaction
          # TODO: set expiration seconds for key
          multi.set(key, data)
        end
        true
      end
    end
  end
end
