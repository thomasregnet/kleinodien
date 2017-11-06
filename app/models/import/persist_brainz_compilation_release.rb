module Import
  # Persist a MusicBrainz release
  class PersistBrainzCompilationRelease < PersistBase
    def self.using_id(args)
      new(args).using_id
    end

    def initialize(args)
      super(args)
    end

    def using_id
      original = mashed_original
      artist_credit = PersistBrainzArtistCredit.using_data(
        template: original.artist_credit,
        cache: cache
      )
      compilation_head = PersistBrainzCompilationHead.using_id(
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
