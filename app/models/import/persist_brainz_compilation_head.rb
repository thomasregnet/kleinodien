module Import
  # Persist a MusicBrainz release-group
  class PersistBrainzCompilationHead < PersistBase
    attr_reader :artist_credit, :cache, :foreign_id

    def self.using_id(args)
      new(args).using_id
    end

    def initialize(args)
      super(args)
    end

    def using_id
      xml = cache.fetch_brainz!(foreign_id)
      original = MashedBrainz::ReleaseGroup.xml(xml)
      artist_credit = PersistBrainzArtistCredit.using_data(
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
