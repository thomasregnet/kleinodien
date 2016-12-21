class Api::V01::ArtistCreditResource < JSONAPI::Resource
  attributes :name
  key_type :integer
  has_many :participants
end
