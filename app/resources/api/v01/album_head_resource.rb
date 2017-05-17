module Api
  module V01
    # JSONAPI::Resources AlbumHead
    class AlbumHeadResource < CompilationHeadResource
      attributes :artist_credit_id # , :title, :disambiguation

      has_one :artist_credit
    end
  end
end
