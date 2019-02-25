# frozen_string_literal: true

# Choose the right class for a MusicBrainz track
class ChooseBrainzPieceClassService
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
  end

  attr_reader :blueprint

  def call
    is_video = blueprint.recording.video
    return 'Video' if is_video && is_video == 'true'

    'Song'
  end
end
