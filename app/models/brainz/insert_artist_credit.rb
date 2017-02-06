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

    # def create_artist(brz_artist)
    #   artist = Artist.find_by(
    #     source:       Source::MusicBrainz,
    #     source_ident: brz_artist.mbid
    #   )

    #   return artist if artist

    #   # TODO: add disambiguation. Maybe needs change in KleinodienBrainz
    #   Artist.create!(
    #     name:         brz_artist.name,
    #     source:       Source::MusicBrainz,
    #     source_ident: brz_artist.mbid
    #   )
    # end
    def create_artist(brz_artist)
      identifier = ArtistIdentifier.find_by(
        source: Source::Brainz,
        value:  brz_artist.mbid
      )

      if identifier
        artist = identifier.artist
        return artist if artist
      end

      identifier = ArtistIdentifier.create!(
        source: Source::MusicBrainz,
        value:  brz_artist.mbid
      )

      artist = identifier.create_artist!(
        name: brz_artist.name
      )
      #byebug

      artist
    end

  end
end
