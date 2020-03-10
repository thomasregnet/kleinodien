# frozen_string_literal: true

# Persist a MusicBrainz Track
class PersistBrainzReleaseTrack < PersistBrainzBase
  def initialize(blueprint:, no:, subset:, **args)
    super(args)
    @blueprint = blueprint
    @no        = no
    @subset    = subset
  end

  # attr_reader :blueprint, :import_order, :no, :subset
  attr_reader :blueprint, :no, :subset

  def call
    subset.tracks.create!(
      import_order: import_order,
      no:           no,
      piece:        piece
    )
  end

  def piece
    persist_piece(code: blueprint.recording.brainz_code)
  end
end
