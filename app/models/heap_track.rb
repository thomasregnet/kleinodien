class HeapTrack < ApplicationRecord
  belongs_to :heap
  belongs_to :import_order
  belongs_to :piece
end
