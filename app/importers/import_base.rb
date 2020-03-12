# frozen_string_literal: true

# Base-Class for import classes
class ImportBase < ServiceBase
  include PersistablePrepareable

  def initialize(import_order:)
    @import_order = import_order
  end

  attr_reader :import_order

  def call
    raise ArgumentError, 'invalid ImportOrder' unless import_order.valid?

    find_existing || try_prepare && persist
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:DuplicateMethodCall
  def persist
    PersistImportService.call(
      blueprint:    blueprint,
      import_order: import_order,
      proxy:        proxy
    )
    # Rails.logger.info("persisting #{import_order.inspect}")

    # proxy.lock

    # imported_entity = try_persistence_transaction
    # if import_order.failed?
    #   Rails.logger.error("failed to persist #{import_order.inspect}")
    #   return
    # end

    # enhance_result(imported_entity, true)
  end

  private

  def find_existing
    result = find_existing_by_import_order \
      || find_existing_by_blueprint \
      || return

    enhance_result(result, false)
  end

  def try_prepare
    import_order.prepare!
    prepare
  rescue StandardError => e
    Rails.logger.error('Failed to prepare')
    handle_error(e)
  end

  # This method smells of :reek:TooManyStatements
  def try_persistence_transaction
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
