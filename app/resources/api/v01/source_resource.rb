module Api
  module V01
    # JSONAPI::Resources Source
    class SourceResource < JSONAPI::Resource
      attributes :name, :description

      filter :name
    end
  end
end
