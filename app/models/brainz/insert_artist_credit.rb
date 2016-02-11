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
      @artist_credit = ArtistCredit.new
      @brz_artist_credit.name_credits.each_with_index do |brz_name_credit, no|
        participant(brz_name_credit, no)
      end
      @artist_credit.save!
      @artist_credit
    end

    def participant(brz_name_credit, no)
      artist = create_artist(brz_name_credit.artist)

      join_phrase = brz_name_credit.joinphrase
      @artist_credit.participants.build(
        artist:      artist,
        join_phrase: join_phrase,
        no:          no
      )
    end

    def create_artist(brz_artist)
      name = brz_artist.name
      # TODO: deal with disambiguation
      artist = Artist.where('lower(name) = ?', name.downcase).first
      return artist if artist
      Artist.create!(name: name) unless artist
    end
  end
end
