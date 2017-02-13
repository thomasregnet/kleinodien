module Brainz
  # Insert a MusicBrainz ArtistCredit
  class InsertArtistCredit
    def self.perform(brz_artist_credit)
      new(brz_artist_credit).perform
    end

    def initialize(brz_artist_credit)
      @brz_artist_credit = brz_artist_credit
    end

    def perform
      ac_name = @brz_artist_credit.joined_artists
      ArtistCredit.find_by(name: ac_name) || create_artist_credit
    end

    private

    def create_artist_credit
      @artist_credit = ArtistCredit.new(
        #data_supplier: DataSupplier.find_or_create_by!(name: 'MusicBrainz')
        source: Source::MusicBrainz
      )

      @brz_artist_credit.name_credits.each_with_index do |brz_name_credit, pos|
        participant(brz_name_credit, pos)
      end

      @artist_credit.save!
      @artist_credit
    end

    def participant(brz_name_credit, position)
      artist = create_artist(brz_name_credit.artist)

      @artist_credit.participants.build(
        artist:      artist,
        join_phrase: brz_name_credit.stripped_joinphrase,
        position:          position
      )
    end

    def create_artist(brz_artist)
      source = Source.find_by(name: 'MusicBrainz')
      identifier = ArtistIdentifier.find_by(
        #source: Source::Brainz,
        source: source,
        value:  brz_artist.mbid
      )



      if identifier
        artist = identifier.artist
        return artist if artist
      end

      artist = Artist.create!(
        name:           brz_artist.name,
        sort_name:      brz_artist.sort_name,
        disambiguation: brz_artist.disambiguation
      )

      identifier = artist.identifiers.create!(
        source: Source::MusicBrainz,
        value:  brz_artist.mbid
      )

      artist
    end
  end
end
