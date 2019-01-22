class Heap < ApplicationRecord
  belongs_to :artist_credit
  belongs_to :import_order
  belongs_to :heap_head
end
