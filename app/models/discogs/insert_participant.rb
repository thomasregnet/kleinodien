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

      dc_artist_name = @dc_artist.name
      artist = Artist.find_by_reference(@dc_artist.id, 'Discogs')
      # TODO: create artist only if no one was found
      artist = Artist.create!(
        name:        dc_artist_name,
        reference:   create_artist_reference(@dc_artist.id)
      ) unless artist

      @artist_credit.participants.build(
        artist:      artist,
        join_phrase: join_phrase,
        no:          @no
      )
    end

    def join_phrase
      join_phrase = @dc_artist.join
      return join_phrase unless join_phrase.blank?
    end

    def create_artist_reference(dc_artist_id)
      ArtistReference.create_with_supplier_name!(dc_artist_id, 'Discogs')
    end
  end
end
