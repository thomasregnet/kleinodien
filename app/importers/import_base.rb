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

  private

  def persist
    persisted_entity = PersistImportService.call(
      # blueprint:    blueprint,
      code:         import_order.code,
      import_order: import_order,
      proxy:        proxy
    )

    enhance_result(persisted_entity, true)

    persisted_entity
  end

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
    handle_prepare_error(e)
  end

  def enhance_result(result, created)
    return unless result

    result.define_singleton_method('created?') { created }
    result
  end

  # This method smells of :reek:DuplicateMethodCall
  def handle_prepare_error(exception)
    Rails.logger.error("Failed to prepare #{import_order.inspect}")
    Rails.logger.error(exception)
    exception.backtrace.each { |msg| Rails.logger.error(msg) }
    import_order.failure!
  end
end
