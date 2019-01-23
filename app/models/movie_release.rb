# frozen_string_literal: true

# A released movie
class MovieRelease < PieceRelease
  belongs_to :head,
             class_name:  'MovieHead',
             foreign_key: :piece_head_id
end
