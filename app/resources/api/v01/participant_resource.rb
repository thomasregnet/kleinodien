class Api::V01::ParticipantResource < JSONAPI::Resource
  attributes :artist_id, :artist_credit_id, :join_phrase, :position
  has_one :artist
  has_one :artist_credit
  key_type :integer
end
