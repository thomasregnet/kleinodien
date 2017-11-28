class DataImport < ApplicationRecord
  validates :note, presence: true

  has_many :artists
  has_many :artist_credits
end
