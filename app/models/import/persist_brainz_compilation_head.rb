module Import
  # Persist a MusicBrainz release-group
  class PersistBrainzCompilationHead
    attr_reader :artist_credit, :cache, :foreign_id

    def self.using_id(foreign_id, cache, artist_credit)
      new(foreign_id, cache, artist_credit).using_id
    end

    def initialize(foreign_id, cache, artist_credit)
      @foreign_id    = foreign_id
      @cache         = cache
      @artist_credit = artist_credit
    end

    def using_id
      xml = cache.fetch_brainz!(foreign_id)
      original = MashedBrainz::ReleaseGroup.xml(xml)
      artist_credit.compilations.create!(
        title:          original.title,
        disambiguation: original.disambiguation,
        type:           'AlbumHead'
      )
    end
  end
end
