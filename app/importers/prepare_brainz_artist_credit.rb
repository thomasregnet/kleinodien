# frozen_string_literal: true

# Prepare a MusicBrainz Artist for import
class PrepareBrainzArtistCredit < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  attr_reader :blueprint

  private

  def prepare
    a_credit = find_already_existing
    return a_credit if a_credit

    blueprint.name_credits.each do |name_credit|
      prepare_brainz_artist(name_credit.artist)
    end

    true
  end

  public

  def find_already_existing
    ArtistCredit.find_by(name: blueprint.join_name)
  end

  def prepare_brainz_artist(artist_blueprint)
    PrepareBrainzArtist.call(
      blueprint:    artist_blueprint,
      import_order: import_order,
      proxy:        proxy
    )
  end
end
