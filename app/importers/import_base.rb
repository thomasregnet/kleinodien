# frozen_string_literal: true

# Base-Class for import classes
class ImportBase < ServiceBase
  def initialize(import_order:)
    @import_order = import_order
  end

  attr_reader :import_order

  def call
    raise ArgumentError, 'invalid ImportOrder' unless import_order.valid?

    find_existing || try_prepare && persist
  end

  def blueprint
    proxy.get(import_request)
  end

  def import_request
    @import_request ||= import_request_class.create(
      code:         import_order.code,
      import_order: import_order
    )
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:DuplicateMethodCall
  def persist
    Rails.logger.info("persisting #{import_order.inspect}")

    proxy.lock

    imported_entity = try_persistence_transaction
    if import_order.failed?
      Rails.logger.error("failed to persist #{import_order.inspect}")
      return
    end

    enhance_result(imported_entity, true)
  end

  private

  def find_existing
    result = find_existing_by_import_order || find_existing_by_blueprint \
      || return

    enhance_result(result, false)
  end

  def try_prepare
    import_order.prepare!
    prepare
    true
  rescue StandardError => e
    e.backtrace.each { |msg| Rails.logger.error(msg) }
    import_order.failure!
    nil
  end

  def import_request_class
    import_order.type.sub(/ImportOrder/, 'ImportRequest').constantize
  end

  # This method smells of :reek:TooManyStatements
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def try_persistence_transaction
    import_order.transaction do
      import_order.persist!
      persister_class.call(
        blueprint:    blueprint,
        import_order: import_order,
        proxy:        proxy
      )
    end
  rescue StandardError => e
    Rails.logger.error(e)
    e.backtrace.each { |msg| Rails.logger.error(msg) }
    import_order.failure!
  ensure
    import_order.done! if import_order.persisting?
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def persister_class
    import_order.type.sub(/^(.+)ImportOrder$/, 'Persist\1').constantize
  end

  def enhance_result(result, created)
    return unless result

    result.define_singleton_method('created?') { created }
    result
  end
end
