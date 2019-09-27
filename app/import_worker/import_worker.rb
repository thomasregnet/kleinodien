# frozen_string_literal: true

# Import from external sources
class ImportWorker
  def self.run(args)
    new(args).run
  end

  # TODO: remove :import_order_class
  def initialize(import_order_class:, import_queue_name:, subscriber:)
    @import_order_class = import_order_class
    @import_queue_name  = import_queue_name
    @subscriber         = subscriber

    raise ArgumentError, "import_queue_name can't be blank" \
      if import_queue_name.blank?
  end

  # TODO: remove :import_order_class
  attr_reader :import_order_class, :import_queue_name, :subscriber

  def run
    loop do
      process_orders
      message = subscriber.perform
      break if message == 'stop'
    end
  end

  # BUG: Fix hard coded ImportQueue-name
  def process_orders
    Rails.logger.info('processing orders')
    loop do
      import_order = ImportQueue.next_pending_for(import_queue_name) || break
      importer_class = importer_class_for(import_order)
      importer_class.call(import_order: import_order)
    end
  end

  private

  def importer_class_for(import_order)
    importer_class = import_order.type.sub(/\A(.+)ImportOrder\z/, 'Import\1')
    Rails.logger.info("importer-class is #{importer_class}")

    importer_class.constantize
  end
end
