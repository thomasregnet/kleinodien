module Api
  module V01
    # JSONAPI::Resources ArtistCredit
    class ArtistCreditResource < JSONAPI::Resource
      attributes :name
      filter :name
      has_many :participants
    end
  end
end
