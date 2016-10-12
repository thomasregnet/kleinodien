FactoryGirl.define do
  factory :piece_release do
    association :head, factory: :piece_head
    type 'PieceRelease'
    source Source::MusicBrainz
    sequence(:source_ident) { |n| "looks-like-brainz-id-#{n}" }

    factory :piece_release_with_tracks do
      transient do
        tracks_count 2
      end

      after(:create) do |piece_release, evaluator|
        create_list(
          :compilation_track,
          evaluator.tracks_count,
          piece_release: piece_release
        )
      end
    end

    factory :piece_release_with_countries do
      after(:create) do |piece_release|
        piece_release.countries << FactoryGirl.create(:country)
        piece_release.countries << FactoryGirl.create(:country)
      end
    end


    factory :piece_release_with_credits do
      transient do
        credits_count 2
      end

      after(:create) do |piece_release, evaluator|
        create_list(
          :pr_credit,
          evaluator.credits_count,
          piece_release: piece_release
        )
      end
    end

    factory :piece_release_with_companies do
      transient do
        companies_count 2
      end

      after(:create) do |piece_release, evaluator|
        create_list(
          :pr_company,
          evaluator.companies_count,
          piece_release: piece_release
        )
      end
    end

    factory :piece_release_with_labels do
      transient do
        labels_count 2
      end

      after(:create) do |piece_release, evaluator|
        create_list(
          :pr_label,
          evaluator.labels_count,
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
