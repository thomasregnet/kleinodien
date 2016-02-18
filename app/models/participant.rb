class Participant < ActiveRecord::Base
  belongs_to :artist, inverse_of: :participants
  belongs_to :artist_credit, inverse_of: :participants
  validates :artist, presence: true
  validates :artist_credit, presence: true
  validates :no, presence: true
  delegate :name, to: :artist
end
