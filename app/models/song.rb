# frozen_string_literal: true

# Version of a song
class Song < Piece
  belongs_to :artist_credit, required: false
  belongs_to :head,
             class_name:  'SongHead',
             foreign_key: :piece_head_id,
             required:    false
end
