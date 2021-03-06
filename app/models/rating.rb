# frozen_string_literal: true

# User ratings for artists, albums, movies ...
class Rating < ApplicationRecord
  POSSIBLE_CONTENTS = %i[
    artist_credit artist compilation_head
    piece_head piece season serial station
  ].freeze

  belongs_to :user

  belongs_to :artist_credit,       required: false
  belongs_to :artist,              required: false
  belongs_to :compilation_head,    required: false
  belongs_to :compilation_release, required: false
  belongs_to :piece_head,          required: false
  belongs_to :piece,               required: false
  belongs_to :season,              required: false
  belongs_to :serial,              required: false
  belongs_to :station,             required: false

  validate :exact_one_content

  validates :value, inclusion: 0..10

  private

  def exact_one_content
    count = 0
    POSSIBLE_CONTENTS.each { |content| count += 1 if send content }
    count != 1 && errors.add(:rating, 'must contain exact one content')
  end
end
