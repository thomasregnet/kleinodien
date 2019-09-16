# frozen_string_literal: true

FactoryBot.define do
  factory :heap_subset do
    association :release, factory: :release
    sequence(:no) { |n| n }
  end
end
