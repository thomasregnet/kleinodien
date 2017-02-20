class Api::V01::ArtistIdentifierResource < JSONAPI::Resource
  attributes :value

  has_one :artist
  has_one :source
end
