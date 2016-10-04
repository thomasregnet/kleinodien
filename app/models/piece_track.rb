class PieceTrack < ApplicationRecord
  belongs_to :piece_releases
  belongs_to :tr_format_kinds
end
