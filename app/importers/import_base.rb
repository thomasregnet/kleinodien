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

    find_existing || prepare && persist
  end

  private

  def persist
    Rails.logger.info("Persisting ImportOrder #{import_order}")
    persisted_entity = PersistImportService.call(
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

  def prepare
    Rails.logger.info("Preparing ImportOrder #{import_order}")
    PrepareImportService.call(
      stub:         blueprint,
      import_order: import_order,
      proxy:        proxy
    )
  end

  def enhance_result(result, created)
    return unless result

    result.define_singleton_method('created?') { created }
    result
  end
end
