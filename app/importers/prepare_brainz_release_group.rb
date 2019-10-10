# frozen_string_literal: true

# Prepare a MusicBrainz release-group for import
class PrepareBrainzReleaseGroup < PrepareBrainzBase
  def initialize(import_request:, **args)
    super(args)
    @import_request = import_request
  end

  attr_reader :import_request

  private

  def prepare
    proxy.get(import_request)
    prepare_artist_credit
  end

  public

  def blueprint
    proxy.get(import_request)
  end

  def prepare_artist_credit
    PrepareBrainzArtistCredit.call(
      blueprint:    blueprint.artist_credit,
      import_order: import_order,
      proxy:        proxy
    )
  end
end
