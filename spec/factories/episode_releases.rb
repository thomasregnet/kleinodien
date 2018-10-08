FactoryBot.define do
  factory :episode_release do
    association :head, factory: :episode_head

    factory :episode_release_with_identifiers do
      transient do
        identifiers_count { 2 }
      end

      after(:create) do |episode_release, evaluator|
        create_list(
          :episode_release_identifier,
          evaluator.identifiers_count,
          identified: episode_release
        )
      end
    end
  end
end
