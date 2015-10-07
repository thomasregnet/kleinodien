FactoryGirl.define do
  factory :piece_head do
    sequence(:title) { |n| "piece ##{n}" }
    type  'PieceHead'

    factory :piece_head_with_credits do
      transient do
        credits_count 2
      end

      after(:create) do |piece_head, elevator|
        create_list(
          :ph_credit,
          elevator.credits_count,
          piece_head: piece_head
        )
      end
    end

    factory :movie_head, class: MovieHead do
      type 'MovieHead'
    end

    factory :podcast_episode_head, class: PodcastEpisodeHead do
      type 'PodcastEpisodeHead'
    end
    
    factory :song_head, class: SongHead do
      artist_credit
      type 'SongHead'
    end

    factory :tv_episode_head, class: TvEpisodeHead do
      type 'TvEpisodeHead'
    end
  end
end
