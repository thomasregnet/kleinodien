# PieceRelease Label
class PrLabel < ActiveRecord::Base
  belongs_to :piece_release
  belongs_to :company
  validates :piece_release, presence: true
  validates :company, presence: true
end
