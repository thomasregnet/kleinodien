FactoryGirl.define do
  factory :piece_release do
    association :head, factory: :piece_head
    type 'Piece'

    factory :piece_release_with_tracks do
      transient do
        tracks_count 2
      end
      
      after(:create) do |piece_release, elevator|
        create_list(:track, elevator.tracks_count, release: piece_release)
      end
    end

    factory :piece_release_with_credits do
      transient do
        credits_count 2
      end

      after(:create) do |piece_release, elevator|
        create_list(
          :pr_credit,
          elevator.credits_count,
          piece_release: piece_release
        )
      end
    end
    
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
