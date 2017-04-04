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
      # TODO: import the artists for ArtistCredit
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

    def import_artist(artist)
      # TODO: check if the artist already exists
      Artist.create!(
        name:           artist.name,
        sort_name:      artist.sort_name,
        disambiguation: artist.disambiguation
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
