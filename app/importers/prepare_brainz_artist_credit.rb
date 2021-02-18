# frozen_string_literal: true

# Prepare a MusicBrainz Artist for import
class PrepareBrainzArtistCredit < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(**args)
    @blueprint = blueprint
  end

  attr_reader :blueprint

  private

  def prepare
    return if ArtistCredit.find_by(name: blueprint.join_name)

    prepare_siblings
  end

  def prepare_siblings
    blueprint.name_credits.each do |name_credit|
      prepare_artist(stub: name_credit.artist)
    end
  end

  public

  def find_already_existing
    ArtistCredit.find_by(name: blueprint.join_name)
  end
end
