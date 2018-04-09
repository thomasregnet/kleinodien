module RedisQueue
  # https://www.tutorialspoint.com/data_structures_algorithms/dsa_queue.htm
  extend ActiveSupport::Concern
  include ImportStore

  attr_reader 'importer_name'

  included do
    define_singleton_method(:name) do |name|
      define_method(:queue_name) { "#{importer_name}:#{name}.queue" }
    end
  end

  def deq
    import_store.lpop(queue_name)
  end

  def enq(object)
    import_store.rpush(queue_name, object)
  end

  def empty?
    !import_store.llen(queue_name).positive?
  end

  def peek
    import_store.lindex(queue_name, 0)
  end
end
