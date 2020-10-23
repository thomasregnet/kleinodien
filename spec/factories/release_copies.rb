# frozen_string_liteal: true

FactoryBot.define do
  factory :release_copy do
    association :user, factory: :user
    association :release, factory: :release

    factory :original_release
  end
end