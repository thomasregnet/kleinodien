module RedisQueue
  # https://www.tutorialspoint.com/data_structures_algorithms/dsa_queue.htm
  extend ActiveSupport::Concern
  # include ImportStore

  # attr_reader 'importer_name'
  attr_reader :importer_name

  included do
    define_singleton_method(:queue_name) do |name|
      define_method(:queue_name) { "#{importer_name}:#{name}:queue" }
    end

    define_singleton_method(:redis) do |redis|
      define_method(:redis) { redis }
    end
  end

  def clear
    redis.del(queue_name)
  end

  def deq
    redis.lpop(queue_name)
  end

  def enq(object)
    redis.rpush(queue_name, object)
  end

  def empty?
    !redis.llen(queue_name).positive?
  end

  def length
    redis.llen(queue_name)
  end

  def peek
    redis.lindex(queue_name, 0)
  end
end
