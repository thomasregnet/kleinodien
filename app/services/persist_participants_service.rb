# frozen_string_literal: true

# Persist ArtistCredit-participants
class PersistParticipantsService < ServiceBase
  def initialize(args)
    @artists       = args[:artists]
    @artist_credit = args[:artist_credit]
    @join_phrases  = args[:join_phrases]
  end

  attr_reader :artists, :artist_credit, :import_order, :join_phrases

  def call
    artists.each_with_index do |artist, position|
      artist_credit.participants.create!(
        artist:      artist,
        join_phrase: join_phrases[position],
        position:    position
      )
    end
  end
end
