class Api::V01::ParticipantResource < JSONAPI::Resource
  attributes :position, :join_phrase
  has_one :artist
  has_one :artist_credit
  key_type :integer
end
