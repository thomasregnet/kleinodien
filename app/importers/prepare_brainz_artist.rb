# frozen_string_literal: true

# Prepare a MusicBrainz artist for import
class PrepareBrainzArtist < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  attr_reader :blueprint

  private

  def prepare
    find_already_existing || proxy.new_get(:artist, blueprint.brainz_code)
  end

  public

  def find_already_existing
    Artist.find_by(brainz_code: blueprint.brainz_code)
  end
end
