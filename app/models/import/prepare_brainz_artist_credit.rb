module Import
  # Import an ArtistCredit from MusicBrainz
  class PrepareBrainzArtistCredit < PrepareBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      super(args)
    end

    def perform
      perform
    end

    def perform
      template.name_credits.each do |name_credit|
        prepare_brainz_artist(foreign_id: name_credit.artist.brainz_id)
        # PrepareBrainzArtist.prepare(
        #   cache:      cache,
        #   foreign_id: name_credit.artist.brainz_id
        # )
      end
    end
  end
end
