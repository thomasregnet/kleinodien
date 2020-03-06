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
    return if ArtistCredit.find_by(name: blueprint.join_name)

    prepare_siblings
  end

  def prepare_siblings
    blueprint.name_credits.each do |name_credit|
      prepare_brainz_artist(name_credit.artist)
    end
  end

  public

  def find_already_existing
    ArtistCredit.find_by(name: blueprint.join_name)
  end

  def prepare_brainz_artist(stub)
    PrepareBrainzArtist.call(
      import_order: import_order,
      proxy:        proxy,
      stub:         stub
    )
  end
end
