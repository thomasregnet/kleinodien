module Import
  # Import an ArtistCredit from MusicBrainz
  class PrepareBrainzArtistCredit < PrepareBase
    attr_reader :artist_credit

    def self.using_data(args)
      new(args).using_data
    end

    def initialize(args)
      @artist_credit = args[:artist_credit]
      super(args)
    end

    def using_data
      prepare
    end

    def prepare
      artist_credit.name_credits.each do |name_credit|
        PrepareBrainzArtist.using_id(
          cache:      cache,
          foreign_id: name_credit.artist.brainz_id
        )
      end
    end
  end
end
