FactoryBot.define do
  factory :album do
    association :head, factory: :album_head

    factory :album_release_with_identifiers do
      transient do
        identifiers_count { 2 }
      end

      after(:create) do |album_release, evaluator|
        create_list(
          :album_release_identifier,
          evaluator.identifiers_count,
          identified: album_release
        )
      end
    end
  end
end
