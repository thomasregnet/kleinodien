FactoryBot.define do
  factory :movie_head do
    sequence(:position) { |n| n }
    sequence(:title) { |n| "movie title ##{n}" }
    # type 'MovieHead'

    factory :movie_head_with_identifiers do
      transient do
        identifiers_count 2
      end

      after(:create) do |movie_head, evaluator|
        create_list(
          :movie_head_identifier,
          evaluator.identifiers_count,
          identified: movie_head
        )
      end
    end
  end
end
