# Version of a song
class SongRelease < PieceRelease
  include Identifyable

  belongs_to :head,
             class_name: 'SongHead',
             foreign_key: :piece_head_id

  validates :head, presence: true
end
