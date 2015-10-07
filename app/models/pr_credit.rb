class PrCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :piece_release
  belongs_to :job
  validates :artist_credit, presence: true
  validates :piece_release, presence: true
end
