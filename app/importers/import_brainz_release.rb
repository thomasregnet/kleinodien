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

  def validate_import_order
    raise ArgumentError, 'invalid ImportOrder' unless import_order.valid?
  end
end
