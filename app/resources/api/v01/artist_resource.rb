class Api::V01::ArtistResource < JSONAPI::Resource
  attributes :name, :disambiguation, :source_name, :source_ident
end
