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
      return if store.missing?
      artist = Artist.brainz(brainz_artist)
      artist.data_import = data_import
      artist.save!
      artist
    end

    private

    def brainz_artist
      store.request!(reference)
    end
  end
end
