module Import
  # Persist a MusicBrainz release
  class PersistBrainzCompilationRelease < PersistBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      super(args)
    end

    def perform
      original = mashed_original
      artist_credit = PersistBrainzArtistCredit.perform(
        template: original.artist_credit,
        cache: cache
      )
      compilation_head = PersistBrainzCompilationHead.perform(
        foreign_id: original.release_group.brainz_id,
        cache: cache
      )
      compilation_head.releases.create!(
        artist_credit: artist_credit,
        title:         original.title
      )
    end

    def mashed_original
      xml = cache.fetch_brainz!(foreign_id)
      ::MashedBrainz::Release.xml(xml)
    end
  end
end
