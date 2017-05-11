FactoryGirl.define do
  factory :movie_release_identifier do
    sequence(:value) { |n| "movie-release-identifier-#{n}" }
    association :identified, factory: :movie_release
    association :source, factory: :source
  end
end
