# frozen_string_literal: true

FactoryBot.define do
  factory :iso3166_part1_country do
    association :area, factory: :area
    sequence(:code, 'A') { |n| "A#{n}" }
  end
end
