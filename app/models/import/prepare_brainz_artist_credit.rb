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
      template.name_credits.each do |name_credit|
        x = prepare_brainz_artist(reference: name_credit.artist.reference)
        # PrepareBrainzArtist.prepare(
        #   cache:      cache,
        #   reference: name_credit.artist.reference
        # )
      end
    end
  end
end
