# frozen_string_literal: true

# Prepares a MusicBrainz Recording for import.
class PrepareBrainzRecording < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @brainz_code = blueprint.brainz_code
  end

  attr_reader :brainz_code

  private

  def blueprint
    @blueprint = proxy.new_get(:recording, brainz_code)
  end

  def prepare
    find_already_existing || prepare_artist_credit
  end

  public

  def find_already_existing
    codes_hash = blueprint.codes_hash
    FindByCodesService.call(model_class: Piece, codes_hash: codes_hash)
  end

  def prepare_artist_credit
    PrepareBrainzArtistCredit.call(
      blueprint:    blueprint.artist_credit,
      import_order: import_order,
      proxy:        proxy
    )
  end
end
