class Api::V01::ArtistResource < JSONAPI::Resource
  attributes :name, :disambiguation, :source_ident

  has_one :source
  key_type :integer
end
