# Version of a song
class SongRelease < PieceRelease
  include Identifyable

  belongs_to :artist_credit, required: false
  belongs_to :head,
             class_name: 'SongHead',
             foreign_key: :piece_head_id
end
