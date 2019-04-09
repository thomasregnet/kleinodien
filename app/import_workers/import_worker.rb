# frozen_string_literal: true

# Call the importers
class ImportWorker
  def initialize(args)
    @importer_class     = args[:importer_class]
    @import_order_class = args[:import_order_class]
    @import_queue_name  = args[:import_queue_name]
  end

  attr_reader :importer_class, :import_order_class
  attr_reader :import_queue, :import_queue_name

  def run
    unsubscribe
    import_order = import_order_class.next_pending
    if import_order
      # importer_class.call(import_order)
      # run
      subscribe
    else
      # subscribe
    end
  end

  def subscribe
    @import_queue = ImportQueue.subscribe(name: import_queue_name)
  end

  def unsubscribe
    return unless import_queue

    import_queue.unsubscribe
  end
end
