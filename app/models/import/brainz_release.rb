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
      artist_credit = import_artist_credit
      album_head = import_album_head(artist_credit)
      import_album_head_identifiers(album_head)
      album_head
    end

    def import_album_head(ac)
      # TODO: check if AlbumHead already exists
      AlbumHead.brainz_create!(
        artist_credit:  ac,
        brainz:         data.release_group
      )
    end

    def import_album_head_identifiers(album_head)
      ChIdentifier.create!(
        compilation_head: album_head,
        source:           Source::MusicBrainz,
        value:            data.release_group.id
      )
    end

    def import_artist_credit
      artist_credit = ArtistCredit.find_or_create_by!(
        name: data.artist_credit.name
      )
      artists = import_artists(data.artist_credit.name_credits)
      import_participants(
        artist_credit,
        artists,
        data.artist_credit.name_credits
      )
      artist_credit
    end

    def import_artists(name_credits)
      name_credits.map { |credit| import_artist(credit.artist) }
    end

    def import_artist(brainz_artist)
      artist = Artist.brainz_create!(brainz_artist)
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

    def import_participants(artist_credit, artists, name_credits)
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
