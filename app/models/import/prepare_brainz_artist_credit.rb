module Import
  # Import an ArtistCredit from MusicBrainz
  class PrepareBrainzArtistCredit
    attr_reader :artist_credit, :cache

    def self.using_data(artist_credit, cache)
      new(artist_credit, cache).using_data
    end

    def initialize(artist_credit, cache)
      @artist_credit = artist_credit
      @cache         = cache
    end

    def using_data
      prepare
    end

    def prepare
      artist_credit.name_credits.each do |name_credit|
        PrepareBrainzArtist.using_id(name_credit.artist.brainz_id, cache)
      end
    end
  end
end
