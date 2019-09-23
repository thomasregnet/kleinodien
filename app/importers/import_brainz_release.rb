# frozen_string_literal: true

# Import a Release from MusicBrainz
class ImportBrainzRelease < ImportBrainzBase
  def call
    validate_import_order
    super
  end

  def find_already_existing
    Release.find_by(brainz_code: import_request.code)
  end

  def prepare
    PrepareBrainzRelease.call(
      blueprint: blueprint,
      proxy:     proxy
    )
  end

  # OPTIMIZE: move #blueprint to ImportBase?
  def blueprint
    proxy.get(import_request)
  end

  def persist
    proxy.lock

    import_order.transaction do
      PersistBrainzRelease.call(
        import_order:   import_order,
        import_request: import_request,
        proxy:          proxy
      )
    end
  end

  def validate_import_order
    raise ArgumentError, 'invalid ImportOrder' unless import_order.valid?

    # kind = import_order.kind
    # raise ArgumentError, "expected kind \"release\" not #{kind}" \
    #   unless kind == 'release'
  end
end
