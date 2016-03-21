# Name giving group of one or many EpisodeReleases
class EpisodeHead < PieceHead
  belongs_to :season, inverse_of: :episodes
  delegate :serial, to: :season
end
