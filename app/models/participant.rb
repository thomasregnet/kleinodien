# An artist participating in an ArtistCredit
class Participant < ActiveRecord::Base
  belongs_to :artist, inverse_of: :participants
  belongs_to :artist_credit, inverse_of: :participants

  validates :position, presence: true

  delegate :name, to: :artist
end
