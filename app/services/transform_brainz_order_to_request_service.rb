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
    @expected_kind = args[:expected_kind]
    @import_order  = args[:import_order]
  end

  def call
    validate

    request_class = BRAINZ_REQUEST_CLASS_FOR[import_order.kind]
    request_class.create!(
      code:         import_order.code,
      import_order: import_order
    )
  end

  attr_reader :expected_kind, :import_order

  def validate
    validate_import_order
    validate_kind
  end

  def validate_import_order
    klass = import_order.class
    return if klass == EXPECTED_ORDER_CLASS

    raise ArgumentError, "Expected a #{EXPECTED_ORDER_CLASS}, not #{klass}"
  end

  def validate_kind
    raise ArgumentError, missing_kind_error_message unless expected_kind
    raise ArgumentError, kinds_do_not_match_error_message unless kinds_match?

    kind = import_order.kind
    return if BRAINZ_REQUEST_CLASS_FOR[kind]

    raise ArgumentError, "Can't handle kind \"#{kind}\""
  end

  def missing_kind_error_message
    'missing parmeter "expected_kind"'
  end

  def kinds_match?
    expected_kind.to_s == import_order.kind.to_s
  end

  def kinds_do_not_match_error_message
    "expected kind \"#{expected_kind}\" bug got #{import_order.kind}"
  end
end
