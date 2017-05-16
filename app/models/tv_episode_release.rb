# An episode-release of an tv-serial-episode
class TvEpisodeRelease < EpisodeRelease
  belongs_to :head,
             class_name:  'TvEpisodeHead',
             foreign_key: :piece_head_id
end
