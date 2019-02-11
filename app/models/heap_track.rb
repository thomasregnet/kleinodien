# frozen_string_literal: true

# Piece that resides on a Heap
class HeapTrack < ApplicationRecord
  belongs_to :import_order
  belongs_to :piece

  composed_of(
    :duration,
    mapping: [%w[milliseconds milliseconds], %w[accuracy accuracy]]
  )

  validates :piece, presence: true
  validates :position, presence: true, blank: false
end
