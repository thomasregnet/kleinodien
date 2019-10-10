# frozen_string_literal: true

# Import from external sources
class ImportWorker
  def self.run(args)
    new(args).run
  end

  def initialize(import_queue_name:, subscriber:)
    @import_queue_name = import_queue_name
    @subscriber        = subscriber

    raise ArgumentError, "import_queue_name can't be blank" \
      if import_queue_name.blank?
  end

  attr_reader :import_queue_name, :subscriber

  def run
    loop do
      process_orders
      message = subscriber.perform
      break if message == 'stop'
    end
  end

  private

  def call_importer
    import_order = next_pending_order || return
    importer_class = importer_class_for(import_order.type) || return

    importer_class.call(import_order: import_order)
  end

  def importer_class_for(import_order_type)
    importer_class = import_order_type.sub(/\A(.+)ImportOrder\z/, 'Import\1')
    Rails.logger.info("importer-class is #{importer_class}")

    importer_class.constantize
  end

  def next_pending_order
    ImportQueue.next_pending_for(import_queue_name)
  end

  def process_orders
    Rails.logger.info('processing orders')
    loop { call_importer || return }
  end
end
