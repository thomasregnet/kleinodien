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
      return if cache.any_required?
      artist = Artist.brainz(brainz_artist)
      artist.save!
      artist
    end

    private

    def brainz_artist
      xml = cache.fetch_brainz!(reference)
      MashedBrainz.from_xml(xml)
    end
  end
end
