# Area or Country
class Country < ActiveRecord::Base
  has_many :descriptions
  has_and_belongs_to_many :compilation_heads
  has_and_belongs_to_many :compilation_releases
  has_and_belongs_to_many :piece_heads
  has_and_belongs_to_many :pieces

  validates :name,
            presence:   true,
            blank:      false,
            uniqueness: { case_sensitive: false }
end
