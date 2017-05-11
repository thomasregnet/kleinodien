FactoryGirl.define do
  factory :song_release do
    association :head, factory: :song_head

    factory :song_release_with_identifiers do
      transient do
        identifiers_count 2
      end

      after(:create) do |song_release, evaluator|
        create_list(
          :song_release_identifier,
          evaluator.identifiers_count,
          identified: song_release
        )
      end
    end
  end
end
