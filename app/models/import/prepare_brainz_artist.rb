module Import
  # Prapare an Artist from MusicBrainz for persistence
  class PrepareBrainzArtist < PrepareBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      super(args)
    end

    def perform
      cache.require_brainz foreign_id unless cache.fetch_brainz(foreign_id)
    end
  end
end
