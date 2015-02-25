class MovieRelease < PieceRelease
  belongs_to :head, class_name: MovieHead, foreign_key: :piece_head_id
  validates :head, presence: true
end
