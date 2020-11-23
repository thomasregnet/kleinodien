# frozen_string_literal: true

FactoryBot.define do
  factory :release_image do
    association :image, factory: :image
    association :release, factory: :release
  end
end