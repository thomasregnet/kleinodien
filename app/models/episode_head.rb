class EpisodeHead < PieceHead
  belongs_to :season, inverse_of: :episodes
end
