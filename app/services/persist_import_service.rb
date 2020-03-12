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

    imported_entity = persist
    if import_order.failed?
      Rails.logger.error("failed to persist #{import_order.inspect}")
      return
    end

    enhance_result(imported_entity, true)
  end

  private

  # This method smells of :reek:TooManyStatements
  def persist
    import_order.transaction do
      import_order.persist!
      persister_class_call
    end
  rescue StandardError => e
    Rails.logger.error('Failed to persist')
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

  def persister_class_call
    persister_class.call(
      blueprint:    blueprint,
      import_order: import_order,
      proxy:        proxy
    )
  end

  def enhance_result(result, created)
    return unless result

    result.define_singleton_method('created?') { created }
    result
  end

  # This method smells of :reek:DuplicateMethodCall
  def handle_error(exception)
    Rails.logger.error(exception)
    exception.backtrace.each { |msg| Rails.logger.error(msg) }
    import_order.failure!
  end
end
