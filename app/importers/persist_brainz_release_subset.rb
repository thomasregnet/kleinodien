# frozen_string_literal: true

# Persist a MusicBrainz medium
class PersistBrainzReleaseSubset < PersistBrainzBase
  def initialize(blueprint:, release:, **args)
    super(args)
    @blueprint = blueprint
    @release   = release
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
      PersistBrainzReleaseTrack.call(
        blueprint:    track,
        # import_order: proxy.import_order,
        import_order: import_order,
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
