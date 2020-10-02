# frozen_string_literal: true

# PieceRelease Credit
class PrCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :piece
end
