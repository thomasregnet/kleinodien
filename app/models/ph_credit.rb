# PieceHead Credit
class PhCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :job
  belongs_to :piece_head
  validates :artist_credit, presence: true
  validates :piece_head, presence: true
end
