# PieceRelease Label
class PrLabel < ActiveRecord::Base
  belongs_to :company
  belongs_to :piece_release
end
