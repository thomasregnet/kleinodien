module Discogs
  # Inserts Discogs Artists to ArtistCredit
  class InsertParticipant
    def self.perform(dc_artist, position, artist_credit)
      new(dc_artist, position, artist_credit).perform
    end

    def initialize(dc_artist, position, artist_credit)
      @dc_artist     = dc_artist
      @position      = position
      @artist_credit = artist_credit
    end

    def perform
      # TODO: move finding of unique case insensitive
      #       artists to the Artist model
      artist = find_artist || create_artist
      @artist_credit.participants.build(
        artist:      artist,
        join_phrase: join_phrase,
        position:    @position
      )
    end

    # def find_artist
    #   Artist.find_by(
    #     source:       Source::Discogs,
    #     source_ident: @dc_artist.id
    #   )
    # end

    def find_artist
      ident = ArtistIdentifier.find_by(
        source: Source::Discogs,
        value:  @dc_artist.id
      ) || return
      Artist.find_by(identifier: ident.id)
    end

    def create_artist
      identifier = ArtistIdentifier.create!(
        source: Source::Discogs,
        value:  @dc_artist.id
      )
      identifier.create_artist(name: @dc_artist.name)
      # Artist.create!(
      #   name:         @dc_artist.name,
      #   source:       Source::Discogs,
      #   source_ident: @dc_artist.id
      # )
    end

    def join_phrase
      join_phrase = @dc_artist.join
      return join_phrase unless join_phrase.blank?
    end
  end
end
