# frozen_string_literal: true

# Persist ArtistCredit-participants
class PersistParticipantsService
  def self.call(args)
    new(args)
  end

  def initialize(args)
    @artists       = args[:artists]
    @artist_credit = args[:artist_credit]
    @join_phrases  = args[:join_phrases]
  end

  attr_reader :artists, :artist_credit, :join_phrases

  def call
    # the code for the service belongs here
  end
end
