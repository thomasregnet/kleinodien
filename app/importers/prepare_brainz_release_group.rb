# frozen_string_literal: true

# Prepare a MusicBrainz release-group for import
class PrepareBrainzReleaseGroup < PrepareBrainzBase
  def initialize(stub:, **args)
    super(args)
    @code = stub.brainz_code
    @stub = stub
  end

  attr_reader :code, :stub

  def prepare
    return if proxy.cached?(:release_group, code)
    return if ReleaseHead.find_by(brainz_code: code)
    return if FindByCodesService.call(
      model_class: ReleaseHead,
      codes_hash:  blueprint.codes_hash
    )

    prepare_artist_credit
  end

  def blueprint
    @blueprint ||= proxy.get(:release_group, code)
  end

  def prepare_artist_credit
    PrepareBrainzArtistCredit.call(
      blueprint:    blueprint.artist_credit,
      import_order: import_order,
      proxy:        proxy
    )
  end
end
