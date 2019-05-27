# frozen_string_literal: true

# Import from external sources
class ImportDaemon
  def self.run(args)
    new(args).run
  end

  def initialize(args)
    @import_order_class = args[:import_order_class]
    @subscriber         = args[:subscriber]
  end

  attr_reader :import_order_class, :subscriber

  def run
    loop do
      process_orders
      message = subscriber.perform
      break if message == 'stop'
    end
  end

  def process_orders
    Rails.logger.info('processing orders')
  #   loop do
  #     import_order = import_order_class.next_pending || break
  #     DeliverImportOrderService.call(import_order: import_order)
  #   end
  end
end
