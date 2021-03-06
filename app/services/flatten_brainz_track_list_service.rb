# frozen_string_literal: true

# Return a flat list combined of track_list and data_track_list
class FlattenBrainzTrackListService < ServiceBase
  def initialize(args)
    @blueprint = args[:blueprint]
  end

  attr_reader :blueprint

  def call
    [tracklist, data_track_list].flatten
  end

  # Use map to copy the tracks
  def tracklist
    # tracks = blueprint.track_list.track
    tracks = blueprint.tracks
    tracks.map { |track| track }
  end

  def data_track_list
    return [] unless data_track_list?

    # tracks = blueprint.data_track_list.track
    tracks = blueprint.data_tracks
    tracks.map { |track| track }
  end

  def data_track_list?
    data_tl = blueprint.data_tracks
    return false unless data_tl

    true
  end
end
