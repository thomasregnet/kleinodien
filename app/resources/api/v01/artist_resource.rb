module Api
  module V01
    # Api-Representation of an artist
    class ArtistResource < JSONAPI::Resource
      attributes :name, :disambiguation, :sort_name

      filters :name, :disambiguation
    end
  end
end
