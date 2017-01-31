class Api::V01::ArtistResource < JSONAPI::Resource
  attributes :name, :disambiguation, :source_ident

  filter :name
  has_one :source
end
