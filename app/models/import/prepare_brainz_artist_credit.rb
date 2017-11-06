module Import
  # Import an ArtistCredit from MusicBrainz
  class PrepareBrainzArtistCredit < PrepareBase
    def self.using_data(args)
      new(args).using_data
    end

    def initialize(args)
      super(args)
    end

    def using_data
      prepare
    end

    def prepare
      template.name_credits.each do |name_credit|
        PrepareBrainzArtist.using_id(
          cache:      cache,
          foreign_id: name_credit.artist.brainz_id
        )
      end
    end
  end
end
