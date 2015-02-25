class PodcastEpisodeRelease < EpisodeRelease
  belongs_to :head, class_name: PodcastEpisodeHead, foreign_key: :piece_head_id
  validates :head, presence: true
end
