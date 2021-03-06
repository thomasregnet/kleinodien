# frozen_string_literal: true

# The Head of one or more song-versions
class SongHead < PieceHead
  belongs_to :artist_credit

  has_many :releases,
           class_name:  'SongRelease',
           foreign_key: :piece_head_id
end
