# The artist releated to an ArtistCredit
class Artist < ActiveRecord::Base
  belongs_to :source, foreign_key: :source_name
  has_many :participants, inverse_of: :artist
  validates :name, presence: true
  validates :name,
            uniqueness: {
              scope:          [:disambiguation, :source],
              case_sensitive: false
            }
end
