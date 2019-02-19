# frozen_string_literal: true

# Prepares a MusicBrainz Recording for import.
class PrepareBrainzRecording < PrepareBrainzBase
  def initialize(args)
    super(args)
    @import_request = args[:import_request]
  end

  attr_reader :import_request

  def call
    piece = find_already_existing
    return piece if piece

    blueprint
    prepare_artist_credit

    nil
  end

  def blueprint
    proxy.get(import_request)
  end

  def find_already_existing
    codes_hash = blueprint.codes_hash
    FindByCodesService.call(model_class: Piece, codes_hash: codes_hash)
  end

  def prepare_artist_credit
    PrepareBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end
end
