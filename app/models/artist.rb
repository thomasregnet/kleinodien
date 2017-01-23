# The artist releated to an ArtistCredit
class Artist < ActiveRecord::Base
  belongs_to :source
  has_many :comments
  has_many :participants, inverse_of: :artist
  has_many :ratings
  validates :name, presence: true
  validates :name,
            uniqueness: {
              scope:          [:disambiguation, :source],
              case_sensitive: false
            }

  delegate :name, to: :source, prefix: :source
end
