# frozen_string_literal: true

# Persist the data of an import
class PersistImportService < ServiceBase
  def initialize(blueprint:, import_order:, proxy:)
    @blueprint    = blueprint
    @import_order = import_order
    @proxy        = proxy
  end

  attr_reader :blueprint, :import_order, :proxy

  def call
    Rails.logger.info("persisting #{import_order.inspect}")

    proxy.lock

    persisted_entity = persist
    return if import_order.failed?

    persisted_entity
  end

  private

  def call_persister_class
    persister_class.call(
      blueprint:    blueprint,
      import_order: import_order,
      proxy:        proxy
    )
  end

  # This method smells of :reek:DuplicateMethodCall
  def handle_error(exception)
    Rails.logger.error("failed to persist #{import_order.inspect}")
    Rails.logger.error(exception)
    exception.backtrace.each { |msg| Rails.logger.error(msg) }
    import_order.failure!
  end

  def persist
    import_order.transaction do
      import_order.persist!
      call_persister_class
    end
  rescue StandardError => e
    handle_error(e)
  ensure
    import_order.done! if import_order.persisting?
  end

  def persister_class
    import_order
      .type
      .sub(/^(.+)ImportOrder$/, 'Persist\1')
      .constantize
  end
end
