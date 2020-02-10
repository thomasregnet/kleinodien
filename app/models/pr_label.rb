# frozen_string_literal: true

# PieceRelease Label
class PrLabel < ActiveRecord::Base
  belongs_to :company
  belongs_to :piece
end
