#!/usr/bin/env ruby

require 'redis'
$stdout.sync = true
puts 'starting fetcher'

# while 1 == 1
#   sleep 9999
# end

redis = Redis.new(host: 'redis', timeout: 3)

redis.subscribe('kleinodien:test') do |on|
  puts 'subscribing'
  on.message do |chanel, message|
    puts "#{chanel}: #{message}"
  end
end
