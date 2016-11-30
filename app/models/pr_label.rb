# PieceRelease Label
class PrLabel < ActiveRecord::Base
  belongs_to :company
  belongs_to :piece_release

  validates :piece_release, presence: true
  validates :company, presence: true
end
