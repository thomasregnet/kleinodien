# frozen_string_literal: true

FactoryBot.define do
  factory :release_event do
    association :area, factory: :area
    association :release, factory: :release
  end
end
