module Import
  # Persist a MusicBrainz release-group
  class PersistBrainzCompilationHead < PersistBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      super(args)
    end

    def perform
      xml = cache.fetch_brainz!(foreign_id)
      original = MashedBrainz::ReleaseGroup.xml(xml)
      artist_credit = PersistBrainzArtistCredit.perform(
        template: original.artist_credit,
        cache:    cache
      )

      artist_credit.compilations.create!(
        title:          original.title,
        disambiguation: original.disambiguation,
        type:           'AlbumHead'
      )
    end
  end
end
