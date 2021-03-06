# frozen_string_literal: true

FactoryBot.define do
  factory :piece_head do
    sequence(:title) { |n| "piece ##{n}" }
    type { 'PieceHead' }

    factory :piece_head_with_countries do
      after(:create) do |piece_head|
        piece_head.countries << FactoryBot.create(:country)
        piece_head.countries << FactoryBot.create(:country)
      end
    end

    factory :piece_head_with_labels do
      transient do
        labels_count { 2 }
      end

      after(:create) do |piece_head, evaluator|
        create_list(
          :ph_label,
          evaluator.labels_count,
          piece_head: piece_head
        )
      end
    end

    # factory :movie_head, class: MovieHead do
    #   type 'MovieHead'
    # end

    factory :podcast_episode_head, class: 'PodcastEpisodeHead' do
      type { 'PodcastEpisodeHead' }
    end

    # factory :song_head, class: SongHead do
    #   artist_credit
    #   type 'SongHead'
    # end

    factory :tv_episode_head, class: 'TvEpisodeHead' do
      type { 'TvEpisodeHead' }
    end
  end
end
