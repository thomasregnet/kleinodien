module Api
  module V01
    # JSONAPI::Resources Participant
    class ParticipantResource < JSONAPI::Resource
      attributes :artist_id, :artist_credit_id, :join_phrase, :position
      has_one :artist
      has_one :artist_credit
    end
  end
end
