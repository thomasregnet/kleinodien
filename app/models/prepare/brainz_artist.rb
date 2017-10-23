module Prepare
  # Prapare an Artist from MusicBrainz for persistence
  class BrainzArtist
    attr_reader :brainz_id, :cache

    def self.using_id(id, cache)
      new(id, cache).using_id
    end

    def initialize(id, cache)
      @brainz_id = BrainzArtistId.new(value: id)
      @cache     = cache
    end

    def using_id
      prepare
      return if cache.any_required?
      # persist
      ::Persist::BrainzArtist.using_id(brainz_id, cache)
    end

    def prepare
      source_id = brainz_id.source_id
      return if cache.required['brainz'].include? source_id
      cache.require_brainz source_id unless cache.fetch_brainz(source_id)
    end
  end
end
