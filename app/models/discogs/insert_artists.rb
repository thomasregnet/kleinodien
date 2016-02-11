module Discogs
  # Insert Artists received from Discogs
  class InsertArtists
    def self.perform(artists)
      new(artists).perform
    end

    def initialize(artists)
      @artists = artists
    end

    def perform
      artist_credit
    end

    private

    def artist_credit
      ac_name = KleinodienDiscogs::JoinArtistNames.perform(@artists)
      ArtistCredit.find_by(name: ac_name) || new_artist_credit
    end

    def new_artist_credit
      artist_credit = ArtistCredit.new
      @artists.each_with_index do |artist, no|
        participant(artist, no, artist_credit)
      end
      artist_credit.save!
      artist_credit
    end

    def participant(dc_artist, no, artist_credit)
      # TODO: move finding of unique case insensitive artists to the Artist model

      artist = Artist.where('lower(name) = ?', dc_artist.name.downcase).first
      artist = Artist.create!(name: dc_artist.name) unless artist

      join_phrase = dc_artist.join  unless dc_artist.join.blank?
      artist_credit.participants.build(
        artist:      artist,
        join_phrase: join_phrase,
        no:          no
      )
    end
  end
end
