class Api::V01::ArtistResource < JSONAPI::Resource
  attributes :name, :disambiguation

  filter :name
  # has_one :source
end
