module Persist
  # Persist a MusicBrainz participant
  class BrainzParticipant
    attr_reader :artist_credit, :cache, :original

    def self.using_data(original, cache)
      new(original, cache).using_data
    end

    def initialize(original, cache)
      @cache = cache
      @original = original
    end

    def using_data
      artist = BrainzArtist.using_id(original.artist.brainz_id, cache)
    end
  end
end
