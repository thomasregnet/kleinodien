# frozen_string_literal: true

FactoryBot.define do
  factory :movie_release do
    sequence(:title) { |n| "song release #{n}" }
    association :head, factory: :movie_head

    factory :movie_release_with_identifiers do
      transient do
        identifiers_count { 2 }
      end

      after(:create) do |movie_release, evaluator|
        create_list(
          :movie_release_identifier,
          evaluator.identifiers_count,
          identified: movie_release
        )
      end
    end
  end
end
