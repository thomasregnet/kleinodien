# frozen_string_literal: true

# Prepare a MusicBrainz Artist for import
class PrepareBrainzArtistCredit
  # This class does not implement +find_already_existing+
  # An artist-credit does not contain it's own id respective code.
  # So we can't search for it. The initial search with the joined name
  # is done by the calling class.
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    blueprint.name_credits.each do |name_credit|
      prepare_brainz_artist(name_credit.artist)
    end

    nil
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
