# PieceHead Label
class PhLabel < ActiveRecord::Base
  belongs_to :company
  belongs_to :piece_head
  validates :company,    presence: true
  validates :piece_head, presence: true
end
