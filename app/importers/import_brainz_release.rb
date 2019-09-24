# frozen_string_literal: true

# Import a Release from MusicBrainz
class ImportBrainzRelease < ImportBrainzBase
  def find_already_existing
    Release.find_by(brainz_code: import_request.code)
  end

  # OPTIMIZE: move #prepare to ImportBase?
  def prepare
    PrepareBrainzRelease.call(
      blueprint: blueprint,
      proxy:     proxy
    )
  end
end
