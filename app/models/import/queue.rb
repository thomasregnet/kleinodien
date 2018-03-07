require 'import_connection'

module Import
  # Queue Import Requests with redis
  module Queue
    include ImportConnection
    def self.run(fetcher_name)
      redis = ImportConnection.redis

      redis.subscribe(fetcher_name) do |on|
        puts "subscribing to #{fetcher_name}"
        on.message do |channel, message|
          puts "#{channel}: #{message}"
        end
      end
    end
  end
end
