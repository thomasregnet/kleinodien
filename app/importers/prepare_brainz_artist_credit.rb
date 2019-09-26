# frozen_string_literal: true

# Prepare a MusicBrainz Artist for import
class PrepareBrainzArtistCredit < PrepareBrainzBase
  def initialize(args)
    super(args)
    @blueprint = args[:blueprint]
  end

  attr_reader :blueprint

  private

  def prepare
    blueprint.name_credits.each do |name_credit|
      prepare_brainz_artist(name_credit.artist)
    end

    nil
  end

  public

  def find_already_existing
    ArtistCredit.find_by(name: blueprint.join_name)
  end

  def prepare_brainz_artist(artist_blueprint)
    artist_import_request = BrainzArtistImportRequest.new(
      code: artist_blueprint.brainz_code
    )

    PrepareBrainzArtist.call(
      import_request: artist_import_request,
      proxy:          proxy
    )
  end
end
