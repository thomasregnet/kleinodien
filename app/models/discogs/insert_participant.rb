module Discogs
  # Inserts Discogs Artists to ArtistCredit
  class InsertParticipant
    def self.perform(dc_artist, no, artist_credit)
      new(dc_artist, no, artist_credit).perform
    end

    def initialize(dc_artist, no, artist_credit)
      @dc_artist     = dc_artist
      @no            = no
      @artist_credit = artist_credit
    end

    def perform
      # TODO: move finding of unique case insensitive
      #       artists to the Artist model
      artist = find_artist || create_artist
      @artist_credit.participants.build(
        artist:      artist,
        join_phrase: join_phrase,
        no:          @no
      )
    end

    def find_artist
      Artist.find_by(
        source:       Source::Discogs,
        source_ident: @dc_artist.id
      )
    end

    def create_artist
      Artist.create!(
        name:         @dc_artist.name,
        source:       Source::Discogs,
        source_ident: @dc_artist.id
      )
    end

    def join_phrase
      join_phrase = @dc_artist.join
      return join_phrase unless join_phrase.blank?
    end
  end
end
