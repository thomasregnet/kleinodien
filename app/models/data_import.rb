class DataImport < ApplicationRecord
  validates :note, presence: true

  has_many :artists
end
