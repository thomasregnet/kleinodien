class Movie < Piece
  belongs_to :head, class_name: 'MovieHead', foreign_key: :piece_head_id
end
