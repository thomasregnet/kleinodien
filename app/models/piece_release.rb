class PieceRelease < ActiveRecord::Base
  belongs_to :head, class_name: PieceHead, foreign_key: :piece_head_id
end
