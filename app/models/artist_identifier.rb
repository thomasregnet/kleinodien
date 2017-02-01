class ArtistIdentifier < ApplicationRecord
  belongs_to :source
  has_one :artist
  validates :source, presence: true
  validates :value, presence: true, blank: false
end
