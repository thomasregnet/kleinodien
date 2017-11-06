module Import
  # Persist a MusicBrainz release-group
  class PersistBrainzCompilationHead < PersistBase
    attr_reader :artist_credit, :cache, :foreign_id

    def self.using_id(foreign_id, cache)
      new(foreign_id, cache).using_id
    end

    def initialize(foreign_id, cache)
      @foreign_id    = foreign_id
      @cache         = cache
    end

    def using_id
      xml = cache.fetch_brainz!(foreign_id)
      original = MashedBrainz::ReleaseGroup.xml(xml)
      artist_credit = PersistBrainzArtistCredit.using_data(
        original.artist_credit, cache
      )

      artist_credit.compilations.create!(
        title:          original.title,
        disambiguation: original.disambiguation,
        type:           'AlbumHead'
      )
    end
  end
end
