class ArtistCredit < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :participants, inverse_of: :artist_credit
  validates :participants, presence: true
end
