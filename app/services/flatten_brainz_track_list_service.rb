# frozen_string_literal: true

# Return a flat list combined of track_list and data_track_list
class FlattenBrainzTrackListService
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
  end

  attr_reader :blueprint

  def call
    [tracklist, data_track_list].flatten
  end

  # Use map to copy the tracks
  def tracklist
    tracks = blueprint.track_list.track
    tracks.map { |track| track }
  end

  def data_track_list
    return [] unless data_track_list?

    tracks = blueprint.data_track_list.track
    tracks.map { |track| track }
  end

  def data_track_list?
    data_tl = blueprint.data_track_list
    return false unless data_tl
    return false unless data_tl.track

    true
  end
end
