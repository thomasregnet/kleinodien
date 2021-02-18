# frozen_string_literal: true

# Persist a MusicBrainz recording
class PersistBrainzPiece < PersistBrainzBase
  def initialize(code:, **args)
    super(**args)
    @code = code
  end

  attr_reader :code

  def call
    find_already_existing || persist
  end

  def find_already_existing
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: Piece
    )
  end

  def blueprint
    proxy.get(:recording, code)
  end

  def duration
    milliseconds = blueprint.milliseconds || return
    Duration.milliseconds(milliseconds)
  end

  def persist
    Piece.create!(
      artist_credit:  artist_credit,
      disambiguation: blueprint.disambiguation,
      duration:       duration,
      import_order:   import_order,
      title:          blueprint.title,
      type:           type
    )
  end

  def artist_credit
    @artist_credit ||= persist_artist_credit(
      blueprint: blueprint.artist_credit
    )
  end

  def type
    ChooseBrainzPieceTypeService.call(blueprint: blueprint)
  end
end
