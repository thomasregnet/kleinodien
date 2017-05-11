FactoryGirl.define do
  factory :episode_release_identifier do
    sequence(:value) { |n| "episode-release-identifier-#{n}" }
    association :identified, factory: :episode_release
    association :source, factory: :source
  end
end
