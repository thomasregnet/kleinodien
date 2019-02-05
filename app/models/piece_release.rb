# frozen_string_literal: true

# A released Piece, may resist on a Heap
class PieceRelease < ApplicationRecord
  belongs_to :import_order, required: false
  belongs_to :piece

  composed_of(
    :duration,
    mapping: [%w[milliseconds milliseconds], %w[accuracy accuracy]]
  )
end
