# frozen_string_literal: true

# Take an ImportOrder and publish it to the import-worker
class PublishImportOrderService < ServiceBase
  def initialize(args)
    @import_order = args[:import_order]
    @message      = args[:message]
  end

  attr_reader :import_order, :message

  def call
    puts "==== #{import_order.import_queue_name} #{message}"
    redis.publish(import_order.import_queue_name, message)
  end

  def redis
    @redis ||= Redis.new(host: 'redis')
  end
  # def call
  #   connection.start
  #   exchange.publish('run', routing_key: import_order.import_queue_name)
  # end

  # private

  # def exchange
  #   channel.direct('import_orders')
  # end

  # def channel
  #   @channel ||= connection.create_channel
  # end

  # def connection
  #   # TODO: get RabbitMQ host name by configuration
  #   @connection ||= Bunny.new(host: 'rabbit')
  # end
end
