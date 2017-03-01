module Api
  module V01
  # Api-Representation of an artist
    class ArtistResource < JSONAPI::Resource
      attributes :name, :disambiguation, :sort_name

      filters :name, :disambiguation

      relationship :identifiers,
                   to: :many,
                   class_name: ArtistIdentifier.to_s
    end
  end
end
