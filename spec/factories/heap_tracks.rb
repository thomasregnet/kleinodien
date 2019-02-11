# frozen_string_literal: true

FactoryBot.define do
  factory :heap_track do
    # TODO: association :subset
    association :piece, factory: :piece
    sequence(:position) { |n| "A#{n}" }
  end
end
