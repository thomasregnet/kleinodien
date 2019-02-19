# frozen_string_literal: true

# Persist a MusicBrainz Track
class PersistBrainzHeapTrack < PersistBrainzBase
  def initialize(args)
    super(args)
    @blueprint    = args[:blueprint]
    @import_order = args[:import_order]
    @no           = args[:no]
    @subset       = args[:subset]
  end

  attr_reader :blueprint, :import_order, :no, :subset

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
