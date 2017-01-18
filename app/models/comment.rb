class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :artist_credit
  belongs_to :artist
  belongs_to :compilation_head
  belongs_to :compilation_release
  belongs_to :piece_head
  belongs_to :piece_release
  belongs_to :repository
  belongs_to :season
  belongs_to :serial
  belongs_to :station

  validates :text, presence: true
  validates :user, presence: true
end
