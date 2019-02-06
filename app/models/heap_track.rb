# frozen_string_literal: true

# Piece that resides on a Heap
class HeapTrack < ApplicationRecord
  belongs_to :heap
  belongs_to :import_order
  belongs_to :piece

  validates :heap, presence: true
  validates :piece, presence: true
  validates :position, presence: true, blank: false
end
