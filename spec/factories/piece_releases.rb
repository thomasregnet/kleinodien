# frozen_string_literal: true

FactoryBot.define do
  factory :piece_release do
    association :piece, factory: :piece

    factory :piece_release_with_heap do
      association :heap, factory: :heap
      sequence(:position) { |n| "position #{n}" }
    end
  end
end
