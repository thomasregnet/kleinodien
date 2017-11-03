module Import
  # Prapare an Artist from MusicBrainz for persistence
  class PrepareBrainzArtist < PrepareBase
    attr_reader :foreign_id, :cache

    def self.using_id(args)
      new(args).using_id
    end

    def initialize(args)
      super(args)
    end

    def using_id
      cache.require_brainz foreign_id unless cache.fetch_brainz(foreign_id)
    end
  end
end
