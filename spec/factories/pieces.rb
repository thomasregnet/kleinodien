# frozen_string_literal: true

FactoryBot.define do
  factory :piece do
    sequence(:title) { |n| "title #{n}" }
    type { 'Piece' }

    factory :piece_with_head do
      association :head, factory: :piece_head
    end

    factory :piece_with_countries do
      after(:create) do |piece|
        piece.countries << FactoryBot.create(:country)
        piece.countries << FactoryBot.create(:country)
      end
    end

    factory :piece_with_labels do
      transient do
        labels_count { 2 }
      end

      after(:create) do |piece, evaluator|
        create_list(
          :pr_label,
          evaluator.labels_count,
          piece: piece
        )
      end
    end

    factory :podcast_episode_release, class: 'PodcastEpisodeRelease' do
      type { 'PodcastEpisodeRelease' }
      association :head, factory: :podcast_episode_head
    end

    factory :tv_episode_release, class: 'TvEpisodeRelease' do
      type { 'TvEpisodeRelease' }
      association :head, factory: :tv_episode_head
    end

    factory :video, class: 'Video' do
    end
  end
end
