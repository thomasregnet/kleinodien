# frozen_string_literal: true

FactoryBot.define do
  factory :heap_subset do
    association :heap, factory: :heap
    sequence(:no) { |n| n }
  end
end
