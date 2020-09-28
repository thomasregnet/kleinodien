# frozen_string_literal: true

FactoryBot.define do
  # TODO: maybe delete this factory
  factory :participant do
    association :artist, factory: :artist
    association :artist_credit, factory: :artist_credit
    sequence(:position) { |n| n }
  end
end
