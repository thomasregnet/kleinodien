require 'redis'

module Fetcher
  def self.run(fetcher_name)
    redis = Redis.new(host: 'redis', timeout: 3)

    redis.subscribe(fetcher_name) do |on|
      puts "subscribing to #{fetcher_name}"
      on.message do |channel, message|
        puts "#{channel}: #{message}"
      end
    end
  end
end
