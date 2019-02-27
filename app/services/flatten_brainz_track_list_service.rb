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
    tracklist = blueprint.track_list.track
    tracklist << data_track_list if data_track_list?
    tracklist.flatten
  end

  def data_track_list
    return unless data_track_list?
    blueprint.data_track_list.track
  end

  def data_track_list?
    return false unless blueprint.data_track_list
    return false unless blueprint.data_track_list.track

    true
  end
end
