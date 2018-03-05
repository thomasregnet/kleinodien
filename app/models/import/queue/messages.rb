module Import
  module Queue
    class Messages
      attr_reader :fetcher_name, :redis

      def self.subscribe(fetcher_name)
        new(fetcher_name).subscribe
      end

      def initialize(fetcher_name)
        # TODO: Redis "host" must be a parameter
        @redis = Redis.new(host: 'redis', timeout: 3)
        @fetcher_name = fetcher_name
      end

      def subscribe
        queue_name = Conventions.message_queue_name_for(fetcher_name)
        redis.subscribe(queue_name) do |on|
          on.message do |channel, message|
            puts "#{channel}, #{message}"
          end
        end
      end

      def unsubscribe
      end
    end
  end
end
