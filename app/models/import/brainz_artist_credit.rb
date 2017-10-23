module Import
  # Import an ArtistCredit from MusicBrainz
  class BrainzArtistCredit
    attr_reader :artist_credit, :cache

    def self.perform(artist_credit, cache)
      new(artist_credit, cache).perform
    end

    def initialize(artist_credit, cache)
      @artist_credit = artist_credit
      @cache         = cache
    end

    def perform
      prepare
    end

    def prepare
      artist_credit.name_credits.each do |name_credit|
        ImportBrainzArtist.perform(name_credit.artist.id, cache)
      end
    end
  end
end
