# Tags
class Tag < ApplicationRecord
  validates :name,
            presence: true,
            blank: false,
            uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :artist_credits
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :compilation_heads
  has_and_belongs_to_many :compilation_releases
  has_and_belongs_to_many :piece_heads
  has_and_belongs_to_many :piece_releases
  has_and_belongs_to_many :seasons
  has_and_belongs_to_many :serials
  has_and_belongs_to_many :stations
end
