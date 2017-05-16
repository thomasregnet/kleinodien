# A podcaste episode, usualy released via the internet
class PodcastEpisodeRelease < EpisodeRelease
  belongs_to :head,
             class_name: 'PodcastEpisodeHead',
             foreign_key: :piece_head_id
end
