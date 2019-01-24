# Tags
class Tag < ApplicationRecord
  validates :name,
            presence: true,
            blank: false,
            uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :artist_credits, required: false
  has_and_belongs_to_many :artists, required: false
  has_and_belongs_to_many :compilation_heads, required: false
  has_and_belongs_to_many :compilation_releases, required: false
  has_and_belongs_to_many :piece_heads, required: false
  # has_and_belongs_to_many :piece_releases, required: false
  has_and_belongs_to_many :pieces, required: false
  has_and_belongs_to_many :seasons, required: false
  has_and_belongs_to_many :serials, required: false
  has_and_belongs_to_many :stations, required: false
end
