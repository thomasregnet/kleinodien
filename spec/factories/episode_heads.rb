FactoryBot.define do
  factory :episode_head do
    season
    sequence(:position) { |n| n }
    sequence(:title) { |n| "episode title ##{n}" }
    type 'EpisodeHead'
    # source Source::Omdb
    # sequence(:source_ident) { |n| n.to_s }

    factory :episode_head_with_identifiers do
      transient do
        identifiers_count 2
      end

      after(:create) do |episode_head, evaluator|
        create_list(
          :episode_head_identifier,
          evaluator.identifiers_count,
          identified: episode_head
        )
      end
    end
  end
end
