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
    artist_credit = persist_artist_credit
    heap_head = persist_heap_head
    # TODO: Persist the right type, not always 'album'
    heap = Heap.create!(
      artist_credit: artist_credit,
      head:          heap_head,
      title:         blueprint.title,
      type:          Album
    )
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

  def persist_subsets(heap)
    blueprint.media.each do |medium|
      PersistBrainzHeapSubset.call(
        blueprint: medium,
        heap:      heap,
        proxy:     proxy
      )
    end
  end
end
