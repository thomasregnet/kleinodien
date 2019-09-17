# frozen_string_literal: true

# Piece that resides on a Heap
class ReleaseTrack < ApplicationRecord
  belongs_to(
    :subset,
    class_name:  'ReleaseSubset',
    foreign_key: :release_subset_id
  )
  belongs_to :import_order, required: false
  belongs_to :piece

  composed_of(
    :duration,
    mapping: [%w[milliseconds milliseconds], %w[accuracy accuracy]]
  )

  validates :no, presence: true
  validates :piece, presence: true
end
