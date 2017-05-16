# PieceHead Credit
class PhCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :job, required: false
  belongs_to :piece_head
end
