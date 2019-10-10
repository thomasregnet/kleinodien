# frozen_string_literal: true

# Prepares a MusicBrainz Recording for import.
class PrepareBrainzRecording < PrepareBrainzBase
  def initialize(import_request:, **args)
    super(args)
    @import_request = import_request
  end

  attr_reader :import_request

  private

  def prepare
    piece = find_already_existing
    return piece if piece

    blueprint
    prepare_artist_credit

    nil
  end

  public

  def blueprint
    proxy.get(import_request)
  end

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
