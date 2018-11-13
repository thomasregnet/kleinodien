# frozen_string_literal: true

# Transform a BrainzImportOrder object to a BrainzImport*Request
class TransformBrainzOrderToRequestService
  BRAINZ_REQUEST_CLASS_FOR = {
    'release' => BrainzReleaseImportRequest
  }.freeze

  def self.call(import_order)
    new(import_order).call
  end

  def initialize(import_order)
    @import_order = import_order
  end

  def call
    validate

    request_class = BRAINZ_REQUEST_CLASS_FOR[import_order.kind]
    request_class.create!(
      code:         import_order.code,
      import_order: import_order
    )
  end

  attr_reader :import_order

  def validate
    validate_import_order
    validate_kind
  end

  def validate_import_order
    klass = import_order.class.to_s
    return if klass == 'BrainzImportOrder'

    raise ArgumentError, "Expected a BrainzImportOrder, not #{klass}"
  end

  def validate_kind
    kind = import_order.kind
    return if BRAINZ_REQUEST_CLASS_FOR[kind]

    raise ArgumentError, "Can't handle kind \"#{kind}\""
  end
end
