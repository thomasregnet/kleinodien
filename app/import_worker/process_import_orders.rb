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
    import_order = next_pending_order
    return unless import_order

    ChooseImporter.call(import_order: import_order)
  end

  # We try some times (next_pending_attempts) to ensure that an ImportOrder that is
  # created by another ImportOrder is visible to the ImportWorker.
  # An ImportOrder may Created by another ImportOrder may not be visible until
  # the transaction of the creating ImportOrder is committed.
  def next_pending_order
    next_pending_attempts.times do |nap_time|
      sleep nap_time
      Rails.logger.debug("trying to get next pending ImportOrder for #{import_queue_name}")
      import_order = ImportQueue.next_pending_for(import_queue_name)
      return import_order if import_order
    end

    nil
  end

  def next_pending_attempts
    return 1 if ENV['RAILS_ENV'] == 'test'

    3
  end
end
