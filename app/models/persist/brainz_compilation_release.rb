module Persist
  # Persist a MusicBrainz release
  class BrainzCompilationRelease
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
      artist_credit = BrainzArtistCredit.using_data(
        original.artist_credit, cache
      )
      compilation_head = Persist::BrainzCompilationHead.using_id(
        original.release_group.brainz_id, cache, artist_credit
      )
      compilation_head.releases.create!(
        title: original.title
      )
    end

    def mashed_original
      xml = cache.fetch_brainz!(id)
      ::MashedBrainz::Release.xml(xml)
    end
  end
end
