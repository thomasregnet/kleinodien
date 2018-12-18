# Prepare a MusicBrainz release-group for import
class PrepareBrainzReleaseGroup
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_request = args[:import_request]
    @proxy          = args[:proxy]
  end

  attr_reader :import_request, :proxy

  def call
    prepare_artist_credit
    nil
  end

  def blueprint
    proxy.get(import_request)
  end

  def prepare_artist_credit
    PrepareBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end
end
