class Participant < ActiveRecord::Base
  belongs_to :artist
  belongs_to :artist_credit
  validates :artist, presence: true
  validates :artist_credit, presence: true
  validates :no, presence: true
end
