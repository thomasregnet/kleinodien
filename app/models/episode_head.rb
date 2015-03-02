class EpisodeHead < PieceHead
  belongs_to :season, inverse_of: :episodes
  delegate :serial, to: :season
end
