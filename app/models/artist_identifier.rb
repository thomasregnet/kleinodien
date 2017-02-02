class ArtistIdentifier < ApplicationRecord
  belongs_to :source
  has_and_belongs_to_many :artists
  has_one :artist
  validates :source, presence: true
  validates :value, presence: true, blank: false
  alias_attribute :identified, :artist
  alias_attribute :alt_identified, :artists
end
