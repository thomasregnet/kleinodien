class Api::V01::ArtistCreditResource < JSONAPI::Resource
  attributes :name
  filter :name
  has_many :participants
end
