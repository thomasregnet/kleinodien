class Api::V01::ArtistIdentifierResource < JSONAPI::Resource
  attributes :value, :artist_id, :source_id

  has_one :artist
  has_one :source
end
