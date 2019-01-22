# frozen_string_literal: true

FactoryBot.define do
  factory :heap_head do
    sequence(:title) { |n| "HeapHead ##{n}" }
  end
end
