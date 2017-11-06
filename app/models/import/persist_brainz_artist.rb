module Import
  # Persist an artist from MusicBrainz
  class PersistBrainzArtist < PersistBase
    def self.using_id(args)
      new(args).using_id
    end

    def initialize(args)
      super(args)
    end

    def using_id
      return if cache.any_required?
      artist = Artist.brainz(brainz_artist)
      artist.save!
      artist
    end

    private

    def brainz_artist
      xml = cache.fetch_brainz!(foreign_id)
      MashedBrainz::Artist.xml(xml)
    end
  end
end
