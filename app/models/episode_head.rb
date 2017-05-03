# Name giving group of one or many EpisodeReleases
class EpisodeHead < PieceHead
  # Podcast episodes do not require a season
  belongs_to :season, required: false, inverse_of: :episodes
  delegate :serial, to: :season
end
