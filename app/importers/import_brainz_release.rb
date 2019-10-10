# frozen_string_literal: true

# Import a Release from MusicBrainz
class ImportBrainzRelease < ImportBrainzBase
  # OPTIMIZE: move #prepare to ImportBase?
  def prepare
    PrepareBrainzRelease.call(
      blueprint:    blueprint,
      import_order: import_order,
      proxy:        proxy
    )
  end

  def find_existing_by_blueprint
    codes_hash = blueprint.codes_hash
    FindByCodesService.call(model_class: Release, codes_hash: codes_hash)
  end

  def find_existing_by_import_order
    Release.find_by(brainz_code: import_order.code)
  end
end
