class Participant < ActiveRecord::Base
  belongs_to :artist
  belongs_to :artist_credit, inverse_of: :participants
  validates :artist, presence: true
  validates :artist_credit, presence: true
  validates :no, presence: true
end
