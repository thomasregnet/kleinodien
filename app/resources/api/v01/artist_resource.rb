class Api::V01::ArtistResource < JSONAPI::Resource
  attributes :name, :disambiguation, :source_name, :source_ident

  has_one :source, foreign_key: :source_name
  key_type :integer
end
