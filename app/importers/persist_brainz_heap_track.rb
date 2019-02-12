# frozen_string_literal: true

# Persist a MusicBrainz Track
class PersistBrainzHeapTrack
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint    = args[:blueprint]
    @import_order = args[:import_order]
    @no           = args[:no]
    @proxy        = args[:proxy]
    @subset       = args[:subset]
  end

  attr_reader :blueprint, :import_order, :no, :proxy, :subset

  def call
    subset.tracks.create!(
      import_order: import_order,
      no:           no,
      piece:        piece
    )
  end

  def piece
    recording_code = blueprint.recording.brainz_code
    import_request = BrainzRecordingImportRequest.new(code: recording_code)

    PersistBrainzPiece.call(
      import_request: import_request,
      proxy:          proxy
    )
  end
end
