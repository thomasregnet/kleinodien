class Api::V01::SourceResource < JSONAPI::Resource
  attributes :name, :description

  filter :name
end


