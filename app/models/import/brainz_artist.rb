module Import
  # Import an Artist from MusicBrainz
  class BrainzArtist
    attr_reader :brainz_id, :cache

    def self.perform(id, cache)
      new(id, cache).perform
    end

    def initialize(id, cache)
      @brainz_id = BrainzArtistId.new(id)
      @cache     = cache
    end

    def perform
      prepare
      persist
    end

    def prepare
      source_id = brainz_id.source_id
      return if cache.required['brainz'].include? source_id
      cache.require_brainz source_id unless cache.fetch_brainz(source_id)
    end

    def persist
      return if cache.any_required?
      artist = Artist.brainz(brainz_artist)
      artist.save!
      artist
    end

    private

    def brainz_artist
      source_id = brainz_id.source_id
      MashedBrainz::Artist.xml(cache.fetch_brainz(source_id))
    end
  end
end
