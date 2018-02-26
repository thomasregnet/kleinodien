require 'redis'

module Fetcher
  def self.run(name)
    redis = Redis.new(host: 'redis', timeout: 3)

    redis.subscribe('kleinodien:test') do |on|
      puts 'subscribing'
      on.message do |chanel, message|
        puts "#{chanel}: #{message}"
      end
    end
  end
end
