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

  end
end
