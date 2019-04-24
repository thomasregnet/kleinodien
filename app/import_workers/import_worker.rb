# frozen_string_literal: true

# Call the importers
class ImportWorker
  def initialize(args)
    @import_order_class = args[:import_order_class]
  end

  attr_reader :import_order_class, :import_queue

  def perform
    unsubscribe
    perform_orders
    subscribe
  end

  def import_queue_name
    import_order_class.import_queue_name
  end

  def perform_orders
    loop do
      import_order = import_order_class.next_pending || break
      DeliverImportOrderService.call(import_order: import_order)
    end
  end

  def subscribe
    return if import_queue # already subscribed

    # TODO: subscribe with a code-block
    @import_queue = ImportQueue.subscribe(name: import_queue_name)
  end

  def unsubscribe
    return unless import_queue

    import_queue.unsubscribe
    @import_queue = nil
  end
end
