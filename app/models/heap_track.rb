# frozen_string_literal: true

# Piece that resides on a Heap
class HeapTrack < ApplicationRecord
  belongs_to :subset, class_name: 'HeapSubset', foreign_key: :heap_subset_id
  belongs_to :import_order, required: false
  belongs_to :piece

  composed_of(
    :duration,
    mapping: [%w[milliseconds milliseconds], %w[accuracy accuracy]]
  )

  validates :no, presence: true
  validates :piece, presence: true
end
