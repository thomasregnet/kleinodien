module Import
  # Prepare a MusicBrainz release to be persisted
  class PrepareBrainzCompilationRelease < PrepareBase
    def self.using_id(args)
      new(args).using_id
    end

    def initialize(args = {})
      super(args)
    end

    def using_id
      # TODO: check if the brainz release already exists in the database
      brainz_release = cached_or_require
      return unless brainz_release
      PrepareBrainzArtistCredit.using_data(brainz_release.artist_credit, cache)
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
