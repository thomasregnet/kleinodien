# frozen_string_literal: true

class PrepareImportService < ServiceBase
  def initialize(import_order:, proxy:, stub:)
    @import_order = import_order
    @proxy        = proxy
    @stub         = stub
  end

  attr_reader :import_order, :proxy, :stub

  def call
    prepare
  end

  private

  def call_preparer_class
    preparer_class.call(
      import_order: import_order,
      proxy:        proxy,
      stub:         stub
    )
  end

  # This method smells of :reek:DuplicateMethodCall
  def handle_prepare_error(exception)
    Rails.logger.error("Failed to prepare #{import_order.inspect}")
    Rails.logger.error(exception)
    exception.backtrace.each { |msg| Rails.logger.error(msg) }
    import_order.failure!
  end

  def prepare
    import_order.prepare!
    call_preparer_class
  rescue StandardError => e
    handle_prepare_error(e)
  end

  def preparer_class
    import_order
      .type
      .sub(/^(.+)ImportOrder/, 'Prepare\1')
      .constantize
  end
end
