class ArtistCredit < ActiveRecord::Base
  validates :name, presence: true
end
