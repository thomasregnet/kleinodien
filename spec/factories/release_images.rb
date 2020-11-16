# frozen_string_literal: true

FactoryBot.define do
  factory :release_image do
    association :release, factory: :release
  end
end