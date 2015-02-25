FactoryGirl.define do
  factory :piece_release do
    #piece_head
    association :head, factory: :piece_head
    type 'Piece'

    factory :song_release, class: SongRelease do
      type 'Song'
      association :head, factory: :song_head
    end

    factory :movie_release, class: MovieRelease do
      type 'Movie'
      association :head, factory: :movie_head
    end

    factory :podcast_episode_release, class: PodcastEpisodeRelease do
      type 'PodcastEpisodeRelease'
      association :head, factory: :podcast_episode_head
    end
    
    factory :tv_episode_release, class: TvEpisodeRelease do
      type 'TvEpisodeRelease'
      association :head, factory: :tv_episode_head
    end
  end
end
