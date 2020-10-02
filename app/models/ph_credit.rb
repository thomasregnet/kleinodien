# frozen_string_literal: true

# PieceHead Credit
class PhCredit < ActiveRecord::Base
  belongs_to :artist_credit
  belongs_to :piece_head
end
