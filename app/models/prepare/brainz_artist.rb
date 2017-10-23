module Prepare
  # Prapare an Artist from MusicBrainz for persistence
  class BrainzArtist
    attr_reader :brainz_id, :cache

    def self.using_id(id, cache)
      new(id, cache).using_id
    end

    def initialize(id, cache)
      @brainz_id = BrainzArtistId.new(id)
      @cache     = cache
    end

    def using_id
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
