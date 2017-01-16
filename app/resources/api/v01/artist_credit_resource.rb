class Api::V01::ArtistCreditResource < JSONAPI::Resource
  attributes :name
  has_many :participants
end
