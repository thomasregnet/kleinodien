# frozen_string_literal: true

# Transform a BrainzImportOrder object to a BrainzImport*Request
class TransformBrainzOrderToRequestService
  def self.call(import_order)
    new(import_order).call
  end

  def initialize(import_order)
    @import_order = import_order
  end

  def call
    validate_import_order
  end

  attr_reader :import_order

  def validate_import_order
    klass = import_order.class
    return if klass == 'BrainzImportOrder'

    raise ArgumentError, "Expected a BrainzImportOrder, not #{klass}"
  end
end
