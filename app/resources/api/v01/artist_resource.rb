class Api::V01::ArtistResource < JSONAPI::Resource
  attributes :name, :disambiguation, :identifier

  filter :name
  # has_one :source
end
