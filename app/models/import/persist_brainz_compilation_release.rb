module Import
  # Persist a MusicBrainz release
  class PersistBrainzCompilationRelease < PersistBase
    attr_reader :cache, :id

    def self.using_id(id, cache)
      new(id, cache).using_id
    end

    def initialize(id, cache)
      @id = id
      @cache = cache
    end

    def using_id
      original = mashed_original
      artist_credit = PersistBrainzArtistCredit.using_data(
        original.artist_credit, cache
      )
      compilation_head = PersistBrainzCompilationHead.using_id(
        original.release_group.brainz_id, cache
      )
      compilation_head.releases.create!(
        artist_credit: artist_credit,
        title:         original.title
      )
    end

    def mashed_original
      xml = cache.fetch_brainz!(id)
      ::MashedBrainz::Release.xml(xml)
    end
  end
end
