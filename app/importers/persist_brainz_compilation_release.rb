# frozen_string_literal: true

# Persist a CompilationRelease using data retrieved from MusicBrainz
class PersistBrainzCompilationRelease
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    # @blueprint = args[:blueprint]
    @import_request = args[:import_request]
    @proxy          = args[:proxy]
  end

  attr_reader :import_request, :proxy

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
    Heap.create!(
      artist_credit: artist_credit,
      head:          heap_head,
      title:         blueprint.title,
      type:          AlbumRelease
    )
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

    PersistBrainzCompilationHead.call(
      # blueprint: proxy.get(import_request),
      import_request: import_request,
      proxy:          proxy
    )
  end
end
