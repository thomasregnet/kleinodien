module Persist
  class BrainzArtist
    attr_reader :cache, :foreign_id

    def self.using_id(foreign_id, cache)
      new(foreign_id, cache).using_id
    end

    def initialize(foreign_id, cache)
      @foreign_id = foreign_id
      @cache      = cache
    end

    def using_id
      return if cache.any_required?
      artist = Artist.brainz(brainz_artist)
      artist.save!
      artist
    end

    private

    def brainz_artist
      xml = cache.fetch_brainz!(foreign_id)
      MashedBrainz::Artist.xml(xml)
    end
  end
end
