# frozen_string_literal: true

# A released Piece, may resist on a Heap
class PieceRelease < ApplicationRecord
  belongs_to :heap, required: false
  belongs_to :import_order, required: false
  belongs_to :piece

  validate :heap_required_if_position_is_present
  validate :position_required_if_heap_is_present

  def heap_required_if_position_is_present
    return unless position.present?
    return if heap.present?

    errors.add(:position, 'heap must be set when position is present')
  end

  def position_required_if_heap_is_present
    return unless heap.present?
    return if position.present?

    errors.add(:heap, 'position must be set when heap is present')
  end
end
