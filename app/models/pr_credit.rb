# PieceRelease Credit
class PrCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :job, required: false
  belongs_to :piece_release

  validates :artist_credit, presence: true
  validates :piece_release, presence: true
end
