# frozen_string_literal: true

# Prepare a MusicBrainz release-group for import
class PrepareBrainzReleaseGroup < PrepareBrainzBase
  def initialize(args)
    super(args)
    @import_request = args[:import_request]
  end

  attr_reader :import_request

  private

  def prepare
    prepare_artist_credit
    nil
  end

  public

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
