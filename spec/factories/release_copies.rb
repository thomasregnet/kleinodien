# frozen_string_liteal: true

FactoryBot.define do
  factory :release_copy do
    sequence(:designation) { |n| "designation #{n}" }
    association :user, factory: :user
    association :release, factory: :release

    factory :original_release
  end
end