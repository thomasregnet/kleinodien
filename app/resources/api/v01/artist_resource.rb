class Api::V01::ArtistResource < JSONAPI::Resource
  attributes :name, :disambiguation, :sort_name

  filter :name
  # has_one :source
end
