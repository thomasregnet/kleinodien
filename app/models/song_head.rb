class SongHead < PieceHead
  belongs_to :artist_credit
  validates :artist_credit, presence: true
end
