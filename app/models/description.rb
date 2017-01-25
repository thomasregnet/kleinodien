class Description < ApplicationRecord
  POSSIBLE_CONTENTS = [
       :artist_credit, :artist, :compilation_head, :compilation_release,
       :country, :piece_head, :piece_release, :season, :serial, :station
  ]

  belongs_to :user
  belongs_to :source

  belongs_to :artist_credit
  belongs_to :artist
  belongs_to :compilation_head
  belongs_to :compilation_release
  belongs_to :country
  belongs_to :piece_head
  belongs_to :piece_release
  belongs_to :season
  belongs_to :serial
  belongs_to :station

  validate :only_one_content

  validates :text, presence: true, blank: false

  private

  def only_one_content
    count = 0
    POSSIBLE_CONTENTS.each { |content| count += 1 if send content }
    if count != 1
      errors.add :description, 'must contain exact one content model'
    end
  end
end
