module Api
  module V01
    # JSONAPI::Resources PieceHead
    class PieceHeadResource < JSONAPI::Resource
      immutable

      attributes :title, :disambiguation
    end
  end
end
