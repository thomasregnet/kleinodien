# Foreign identifier of Artist
class ArtistIdentifier < ApplicationRecord
  belongs_to :source
  belongs_to :artist
  validates :artist, presence: true
  validates :source, presence: true
  validates :value, presence: true, blank: false
  alias_attribute :identified, :artist
end
