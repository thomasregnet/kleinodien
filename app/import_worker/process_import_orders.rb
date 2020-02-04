# frozen_string_literal: true

# Process Import Orders
class ProcessImportOrders < ServiceBase
  def initialize(import_queue_name:)
    @import_queue_name = import_queue_name
  end

  attr_reader :import_queue_name

  def call
    Rails.logger.info("processing import orders on #{import_queue_name}")

    loop { call_importer || return }
  end

  private

  def call_importer
    import_order = next_pending_order || return

    ChooseImporter.call(import_order: import_order)
  end

  def next_pending_order
    ImportQueue.next_pending_for(import_queue_name)
  end
end
