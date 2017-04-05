module Import
  # Import an album from MusicBrainz
  class BrainzRelease
    attr_reader :data

    def self.perform(data)
      new(data).perform
    end

    def initialize(data)
      multi_xml = MultiXml.parse(data)['metadata']['release']
      @data     = MashedBrainz::Release.new(multi_xml)
    end

    def perform
      artist_credit
    end

    def artist_credit
      ac_name = artist_credit_name
      ac = ArtistCredit.find_by(name: ac_name)
      return ac if ac
      ac = ArtistCredit.create!(name: ac_name)
      artists = import_artists(data.artist_credit.name_credits)
      participants(ac, artists, data.artist_credit.name_credits)
      ac
    end

    def artist_credit_name
      data.artist_credit.name
    end

    def import_artists(name_credits)
      name_credits.map { |credit| import_artist(credit.artist) }
    end

    def import_artist(brainz_artist)
      artist = Artist.brainz_create!(brainz_artist) #.save!

      import_artist_identifier(artist, brainz_artist.id)
      artist
    end

    def import_artist_identifier(artist, value)
      ArtistIdentifier.create!(
        artist: artist,
        source: Source::MusicBrainz,
        value:  value
      )
    end

    def participants(artist_credit, artists, name_credits)
      artists.each_with_index do |artist, no|
        join_phrase = name_credits[no].stripped_joinphrase
        Participant.create!(
          artist:        artist,
          artist_credit: artist_credit,
          join_phrase:   join_phrase,
          position:      no
        )
      end
    end
  end
end
