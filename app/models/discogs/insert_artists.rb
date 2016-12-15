module Discogs
  # Insert Artists received from Discogs
  class InsertArtists
    def self.perform(artists)
      new(artists).perform
    end

    def initialize(artists)
      @artists = artists
      @source  = Source::Discogs
    end

    def perform
      artist_credit
    end

    private

    def artist_credit
      ac_name = KleinodienDiscogs::JoinArtistNames.perform(@artists)
      ArtistCredit.find_by(
        name:   ac_name,
        source: @source
      ) || new_artist_credit
    end

    def new_artist_credit
      artist_credit = ArtistCredit.new(source: @source)
      @artists.each_with_index do |artist, position|
        Discogs::InsertParticipant.perform(artist, position, artist_credit)
      end
      artist_credit.save!
      artist_credit
    end
  end
end
