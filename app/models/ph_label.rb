# frozen_string_literal: true

# PieceHead Label
class PhLabel < ActiveRecord::Base
  belongs_to :company
  belongs_to :piece_head
end
