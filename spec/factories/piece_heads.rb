FactoryGirl.define do
  factory :piece_head do
    sequence(:title) { |n| "piece ##{n}" }
    type  'PieceHead'
    #source Source::MusicBrainz
    #sequence(:source_ident) { |n| "looks-like-a-brainz-id-#{n}" }

    factory :piece_head_with_companies do
      transient do
        companies_count 2
      end

      after(:create) do |piece_head, evaluator|
        create_list(
          :ph_company,
          evaluator.companies_count,
          piece_head: piece_head
        )
      end
    end

    factory :piece_head_with_countries do
      after(:create) do |piece_head|
        piece_head.countries << FactoryGirl.create(:country)
        piece_head.countries << FactoryGirl.create(:country)
      end
    end

    factory :piece_head_with_credits do
      transient do
        credits_count 2
      end

      after(:create) do |piece_head, evaluator|
        create_list(
          :ph_credit,
          evaluator.credits_count,
          piece_head: piece_head
        )
      end
    end

    factory :piece_head_with_labels do
      transient do
        labels_count 2
      end

      after(:create) do |piece_head, evaluator|
        create_list(
          :ph_label,
          evaluator.labels_count,
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

    # factory :song_head, class: SongHead do
    #   artist_credit
    #   type 'SongHead'
    # end

    factory :tv_episode_head, class: TvEpisodeHead do
      type 'TvEpisodeHead'
    end
  end
end
