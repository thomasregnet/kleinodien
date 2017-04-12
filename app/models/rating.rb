# User ratings for artists, albums, movies ...
class Rating < ApplicationRecord
  POSSIBLE_CONTENTS = %i(
    artist_credit artist compilation_head compilation_release
    piece_head piece_release season serial station
  ).freeze

  belongs_to :user
  belongs_to :artist_credit
  belongs_to :artist
  belongs_to :compilation_head
  belongs_to :compilation_release
  belongs_to :piece_head
  belongs_to :piece_release
  belongs_to :season
  belongs_to :serial
  belongs_to :station

  validate :exact_one_content

  validates :user, presence: true
  validates :value, inclusion: 0..10

  private

  def exact_one_content
    count = 0
    POSSIBLE_CONTENTS.each { |content| count += 1 if send content }
    count != 1 && errors.add(:rating, 'must contain exact one content')
  end
end
