# frozen_string_literal: true

# Persist a MusicBrainz recording
class PersistBrainzPiece
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_request = args[:import_request]
    @proxy          = args[:proxy]
  end

  attr_reader :import_request, :proxy

  def call
    find_already_existing || persist
  end

  def find_already_existing
    # TODO: add disambiguation
    # TODO: handle model class
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: Piece
    )
  end

  def blueprint
    proxy.get(import_request)
  end

  def persist
    # TODO: handle model class
    Piece.create!(
      artist_credit:  persist_artist_credit,
      disambiguation: blueprint.disambiguation,
      title:          blueprint.title,
      type:           'SongRelease'
    )
  end

  def persist_artist_credit
    PersistBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end
end
