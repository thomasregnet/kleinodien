# frozen_string_literal: true

# Base class for import queues
class ImportQueueBase
  define_singleton_method(:name) do |value|
    define_method(:name) { value.to_s }
  end

  def channel
    @channel ||= connection.create_channel
  end

  def connection
    # TODO: get RabbitMQ host name by configuration
    @connection ||= Bunny.new(host: 'rabbit')
  end

  def exchange
    channel.fanout(name)
  end
end
