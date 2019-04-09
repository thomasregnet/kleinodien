# frozen_string_literal: true

# Call the importers
class ImportWorker
  def initialize(args)
    @import_order_class = args[:import_order_class]
    @import_queue_name  = args[:import_queue_name]
  end

  attr_reader :import_order_class, :import_queue, :import_queue_name

  def run
    unsubscribe
    import_order = import_order_class.next_pending
    if import_order
      DeliverImportOrderService.call(import_order: import_order)
      # run
    else
      # subscribe
    end
  end

  def subscribe
    return if import_queue # already subscribed

    @import_queue = ImportQueue.subscribe(name: import_queue_name)
  end

  def unsubscribe
    return unless import_queue

    import_queue.unsubscribe
    @import_queue = nil
  end
end
