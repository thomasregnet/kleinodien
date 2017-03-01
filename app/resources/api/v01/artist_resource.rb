class Api::V01::ArtistResource < JSONAPI::Resource
  attributes :name, :disambiguation, :sort_name

  filters :name, :disambiguation
  # has_one :source
end
