# A released movie
class MovieRelease < PieceRelease
  include Identifyable

  belongs_to :head,
             class_name: 'MovieHead',
             foreign_key: :piece_head_id

  validates :head, presence: true
end
