# frozen_string_literal: true

# A Heap of Pieces
class Heap < ApplicationRecord
  belongs_to :artist_credit, required: false
  belongs_to :import_order, required: false
  belongs_to :head, class_name: 'HeapHead', foreign_key: :heap_head_id
end
