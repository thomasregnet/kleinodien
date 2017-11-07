module Import
  # Prepare a MusicBrainz release to be persisted
  class PrepareBrainzCompilationRelease < PrepareBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args = {})
      super(args)
    end

    def perform
      # TODO: check if the brainz release already exists in the database
      brainz_release = cached_or_require
      return unless brainz_release
      PrepareBrainzArtistCredit.perform(
        template: brainz_release.artist_credit,
        cache:         cache
      )
      # TODO: Use MaschedBrainz if they are available
      # TODO: call `prepare` on related classes
    end

    def cached_or_require
      xml = cache.fetch_brainz(foreign_id)
      cache.require_brainz(foreign_id) unless xml
      return false unless xml
      MashedBrainz::Release.xml(xml)
    end
  end
end
