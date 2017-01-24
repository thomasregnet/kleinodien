# User comments on contents
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

  validate :only_one_content

  private

  def only_one_content
    contents = [
      :artist_credit, :artist, :compilation_head, :compilation_release,
      :piece_head, :piece_release, :repository, :season, :serial, :station
    ]

    count = 0
    contents.each { |content| count += 1 if send content }
    count != 1 && errors.add(:comment, 'must contain exact one content')
  end
end
