# frozen_string_literal: true

FactoryBot.define do
  # TODO: maybe delete this factory
  factory :participant do
    sequence(:position) { |n| n }
  end
end
