# frozen_string_literal: true

# Import a Release from MusicBrainz
class ImportBrainzRelease
  def self.call(import_order)
    new(import_order).call
  end

  def initialize(import_order)
    @import_order = import_order
  end

  attr_reader :import_order

  def call
    # validate

    import_request = TransformBrainzOrderToRequestService.call(
      expected_kind: :release,
      import_order:  import_order
    )
    # TODO: call PrepareBrainzRelease with useful args
    PrepareBrainzRelease.call(:some_thing)
  end

  def validate
    validate_import_order_class
    validate_kind
  end

  def validate_import_order_class
    return if import_order.class == BrainzImportOrder

    raise ArgumentError, 'Must be called with a BrainzImportOrder'
  end

  def validate_kind
    kind = import_order.kind
    return if kind == 'release'

    raise ArgumentError, "Expected \"release\" as kind, got \"#{kind}\""
  end
end
