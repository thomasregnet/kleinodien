class Api::V01::PieceHeadResource < JSONAPI::Resource
  immutable

  attributes :title, :disambiguation
end
