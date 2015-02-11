class ArtistCredit < ActiveRecord::Base
  has_many :artists, through: :participants
  has_many :participants, inverse_of: :artist_credit
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :participants, presence: true
end
