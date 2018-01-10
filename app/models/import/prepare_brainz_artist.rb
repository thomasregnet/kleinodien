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
      ask.about(reference)
    end
  end
end
