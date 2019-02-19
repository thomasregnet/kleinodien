# frozen_string_literal: true

# Persist a MusicBrainz medium
class PersistBrainzHeapSubset < PersistBrainzBase
  def initialize(args)
    super(args)
    @blueprint = args[:blueprint]
    @heap      = args[:heap]
  end

  attr_reader :blueprint, :heap

  def call
    subset = heap.subsets.create!(no: blueprint.position, title: title)
    persist_tracks(subset)
    subset
  end

  def persist_tracks(subset)
    blueprint.track_list.track.each.with_index(1) do |track, no|
      # TODO: don't take import_order form proxy
      PersistBrainzHeapTrack.call(
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
