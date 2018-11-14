module Importer
  # Prapare an Artist from MusicBrainz for persistence
  class OldPrepareBrainzArtist < PrepareBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      super(args)
    end

    def perform
      store.request(reference)
    end
  end
end
