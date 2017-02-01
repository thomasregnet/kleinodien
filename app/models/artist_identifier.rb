class ArtistIdentifier < ApplicationRecord
  belongs_to :source

  validates :source, presence: true
  validates :value, presence: true, blank: false
end
