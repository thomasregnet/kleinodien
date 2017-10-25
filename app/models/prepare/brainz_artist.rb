module Prepare
  # Prapare an Artist from MusicBrainz for persistence
  class BrainzArtist
    attr_reader :foreign_id, :cache

    def self.using_id(foreign_id, cache)
      new(foreign_id, cache).using_id
    end

    def initialize(foreign_id, cache)
      @foreign_id = foreign_id
      @cache      = cache
    end

    # def using_id
    #   prepare
    #   return if cache.any_required?
    #   # persist
    #   ::Persist::BrainzArtist.using_id(foreign_id, cache)
    # end

    def using_id
      # return if cache.required['brainz'].include? foreign_id # source_id
      cache.require_brainz foreign_id unless cache.fetch_brainz(foreign_id)
    end
  end
end
