module Api
  module V01
    class PieceHeadResource < JSONAPI::Resource
      immutable

      attributes :title, :disambiguation
    end
  end
end
