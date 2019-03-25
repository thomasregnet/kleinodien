# frozen_string_literal: true

class PublishImportOrderService < ServiceBase
  def initialize(args)
    @import_order_type = args[:import_order_type]
  end

  attr_reader :import_order_type

  def call
    connection.start
    exchange.publish('run', routing_key: import_order_type)
  end

  private

  def exchange
    channel.direct('import_orders')
  end

  def channel
    @channel ||= connection.create_channel
  end

  def connection
    # TODO: get RabbitMQ host name by configuration
    @connection ||= Bunny.new(host: 'rabbit')
  end
end
