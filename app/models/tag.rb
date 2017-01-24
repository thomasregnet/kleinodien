class Tag < ApplicationRecord
  validates :name,
            presence: true,
            blank: false,
            uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :artist_credits
end
