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
      store.ask_for(reference)
    end
  end
end
