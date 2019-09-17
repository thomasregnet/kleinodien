# frozen_string_literal: true

# Persist a MusicBrainz medium
class PersistBrainzReleaseSubset < PersistBrainzBase
  def initialize(args)
    super(args)
    @blueprint = args[:blueprint]
    @release   = args[:release]
  end

  attr_reader :blueprint, :release

  def call
    subset = release.subsets.create!(no: blueprint.position, title: title)
    persist_tracks(subset)
    subset
  end

  def persist_tracks(subset)
    tracklist = blueprint.flat_track_list
    tracklist.each.with_index(1) do |track, no|
      # TODO: don't take import_order form proxy
      PersistBrainzReleaseTrack.call(
        blueprint:    track,
        import_order: proxy.import_order,
        no:           no,
        proxy:        proxy,
        subset:       subset
      )
    end
  end

  def title
    title = blueprint.title
    return title if title

    "#{blueprint.format.__content__} #{blueprint.position}"
  end
end
