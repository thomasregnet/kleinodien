# Prepare a MusicBrainz release-group for import
class PrepareBrainzReleaseGroup
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    prepare_artist_credit
    nil
  end

  def prepare_artist_credit
    return if find_already_existing_artist_credit

    PrepareBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end

  def find_already_existing_artist_credit
    ArtistCredit.find_by(name: blueprint.artist_credit.join_name)
  end
end
