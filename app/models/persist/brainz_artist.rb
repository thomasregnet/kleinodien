module Persist
  class BrainzArtist
    attr_reader :cache, :source_id

    def self.using_id(id, cache)
      new(id, cache).using_id
    end

    def initialize(source_id, cache)
      @source_id = source_id
      @cache     = cache
    end

    def using_id
      return if cache.any_required?
      artist = Artist.brainz(brainz_artist)
      artist.save!
      artist
    end

    private

    def brainz_artist
      # TODO: Call source_id.source_id looks wired, fix that
      id = source_id.source_id
      MashedBrainz::Artist.xml(cache.fetch_brainz(id))
    end
  end
end
