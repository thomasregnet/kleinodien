class Api::V01::ArtistIdentifierResource < JSONAPI::Resource
  attributes :value, :artist_id, :source_id

  filters :artist_id, :source_id, :value

  has_one :artist
  has_one :source
end
