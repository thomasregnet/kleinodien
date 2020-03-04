# frozen_string_literal: true

# Prepare a MusicBrainz release-group for import
class PrepareBrainzReleaseGroup < PrepareBrainzBase
  # In order to prepare also the ArtistCredit of the ReleaseGroup
  # this class needs to be called with an ImportRequest.
  # The blueprint of a release/release-group does not contain
  # the ArtistCredit.
  def initialize(blueprint:, **args)
    super(args)
    @code = blueprint.brainz_code
  end

  attr_reader :code

  def prepare
    find_already_existing || prepare_artist_credit
  end

  def blueprint
    @blueprint ||= proxy.new_get(:release_group, code)
  end

  def find_already_existing
    ReleaseHead.find_by(brainz_code: code)
  end

  def prepare_artist_credit
    PrepareBrainzArtistCredit.call(
      blueprint:    blueprint.artist_credit,
      import_order: import_order,
      proxy:        proxy
    )
  end
end
