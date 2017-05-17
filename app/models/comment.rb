# User comments on contents
class Comment < ApplicationRecord
  belongs_to :user,                required: false
  belongs_to :artist,              required: false
  belongs_to :artist_credit,       required: false
  belongs_to :artist,              required: false
  belongs_to :compilation_head,    required: false
  belongs_to :compilation_release, required: false
  belongs_to :piece_head,          required: false
  belongs_to :piece_release,       required: false
  belongs_to :repository,          required: false
  belongs_to :season,              required: false
  belongs_to :serial,              required: false
  belongs_to :station,             required: false

  validates :text, presence: true
  validates :user, presence: true

  validate :only_one_content

  private

  def only_one_content
    contents = %i[
      artist_credit artist compilation_head compilation_release
      piece_head piece_release repository season serial station
    ]

    count = 0
    contents.each { |content| count += 1 if send content }
    count != 1 && errors.add(:comment, 'must contain exact one content')
  end
end
