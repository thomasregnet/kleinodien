# Describe things
class Description < ApplicationRecord
  POSSIBLE_CONTENTS = %i[
    artist_credit artist compilation_head compilation_release
    country piece_head piece season serial station
  ].freeze

  belongs_to :user,   required: false
  belongs_to :source, required: false

  belongs_to :artist_credit,       required: false
  belongs_to :artist,              required: false
  belongs_to :compilation_head,    required: false
  belongs_to :compilation_release, required: false
  belongs_to :country,             required: false
  belongs_to :piece_head,          required: false
  belongs_to :piece,               required: false
  belongs_to :season,              required: false
  belongs_to :serial,              required: false
  belongs_to :station,             required: false

  validate :only_one_content

  validates :text, presence: true, blank: false

  private

  def only_one_content
    count = 0
    POSSIBLE_CONTENTS.each { |content| count += 1 if send content }
    must_contain_exact_one_content_model(count)
  end

  def must_contain_exact_one_content_model(count)
    return if count == 1
    errors.add(:description, 'must contain exact one content model')
  end
end
