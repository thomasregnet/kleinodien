# frozen_string_literal: true

# Transform a BrainzImportOrder object to a BrainzImport*Request
class TransformBrainzOrderToRequestService
  BRAINZ_REQUEST_CLASS_FOR = {
    'release' => BrainzReleaseImportRequest
  }.freeze
  EXPECTED_ORDER_CLASS = BrainzImportOrder

  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_order = args[:import_order]
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
    raise ArgumentError, 'invalid ImportOrder' unless import_order.valid?

    klass = import_order.class
    return if klass == EXPECTED_ORDER_CLASS

    raise ArgumentError, "Expected a #{EXPECTED_ORDER_CLASS}, not #{klass}"
  end

  def validate_kind
    kind = import_order.kind
    return if BRAINZ_REQUEST_CLASS_FOR[kind]

    raise ArgumentError, "Can't handle kind \"#{kind}\""
  end

  def kinds_do_not_match_error_message
    "expected kind \"#{expected_kind}\" bug got #{import_order.kind}"
  end
end
