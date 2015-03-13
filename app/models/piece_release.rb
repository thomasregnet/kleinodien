class PieceRelease < ActiveRecord::Base
  belongs_to :head, class_name: PieceHead, foreign_key: :piece_head_id
  has_many :tracks
  delegate :title, to: :head
end
