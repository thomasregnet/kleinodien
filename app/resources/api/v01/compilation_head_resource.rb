class Api::V01::CompilationHeadResource < JSONAPI::Resource
  immutable

  attributes :disambiguation, :title
end
