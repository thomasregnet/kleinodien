# frozen_string_literal: true

# Import a Release from MusicBrainz
class ImportBrainzRelease
  def self.call(import_order)
    new(import_order).call
  end

  def initialize(args)
    @import_order = args[:import_order]
  end

  attr_reader :import_order

  def call
    # By creating the import_request the import_order values is validated.
    # So we create the import_request at the very first time.
    validate_import_order

    result = find_already_existing || prepare
    return { result: result, new_record: false } if result

    result = persist
    { result: result, new_record: true }
  end

  def find_already_existing
    Heap.find_by(brainz_code: import_request.code)
  end

  def import_request
    @import_request ||= TransformBrainzOrderToRequestService.call(
      import_order: import_order
    )
  end

  def prepare
    PrepareBrainzRelease.call(
      blueprint: blueprint,
      proxy:     proxy
    )
  end

  def blueprint
    proxy.get(import_request)
  end

  def proxy
    @proxy ||= BrainzProxy.new(import_order: import_order)
  end

  def persist
    proxy.lock

    import_order.transaction do
      PersistBrainzHeap.call(
        import_request: import_request,
        proxy:          proxy
      )
    end
  end

  def validate_import_order
    raise ArgumentError, 'invalid ImportOrder' unless import_order.valid?

    kind = import_order.kind
    raise ArgumentError, "expected kind \"release\" not #{kind}" \
      unless kind == 'release'
  end
end
