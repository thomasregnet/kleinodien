module Import
  # Persist an artist from MusicBrainz
  class PersistBrainzArtist < PersistBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      super(args)
    end

    def perform
      return if knowledge.missing?
      artist = Artist.brainz(brainz_artist)
      artist.data_import = data_import
      artist.save!
      artist
    end

    private

    def brainz_artist
      ask.about!(reference)
    end
  end
end
