# frozen_string_literal: true

# Persist a CompilationRelease using data retrieved from MusicBrainz
class PersistBrainzHeap < PersistBrainzBase
  def initialize(args)
    super(args)
    @import_request = args[:import_request]
  end

  attr_reader :import_request

  def call
    find_already_existing || persist
  end

  def blueprint
    proxy.get(import_request)
  end

  def find_already_existing
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: Heap
    )
  end

  def persist
    heap = Heap.create!(
      artist_credit: persist_artist_credit,
      head:          persist_heap_head,
      title:         blueprint.title,
      type:          type
    )
    persist_media(heap)
    persist_subsets(heap)
    heap
  end

  def persist_artist_credit
    PersistBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end

  def persist_heap_head
    import_request = BrainzReleaseGroupImportRequest.new(
      code: blueprint.release_group.brainz_code
    )

    PersistBrainzHeapHead.call(
      # blueprint: proxy.get(import_request),
      import_request: import_request,
      proxy:          proxy
    )
  end

  # This method smells of :reek:FeatureEnvy
  def persist_media(heap)
    reduced_media.each.with_index(1) do |heap_medium, position|
      heap.media.create!(
        format:   heap_medium[:medium_format],
        position: position,
        quantity: heap_medium[:quantity]
      )
    end
  end

  def persist_subsets(heap)
    blueprint.media.each do |medium|
      PersistBrainzHeapSubset.call(
        blueprint: medium,
        heap:      heap,
        proxy:     proxy
      )
    end
  end

  def reduced_media
    ReduceBrainzHeapMediaService.call(
      blueprint:    blueprint.media,
      import_order: import_order
    )
  end

  def type
    ChooseBrainzHeapTypeService.call(brainz_type: blueprint.release_group.type)
  end
end
