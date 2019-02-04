class PieceRelease < ApplicationRecord
  belongs_to :heap
  belongs_to :import_order
end
