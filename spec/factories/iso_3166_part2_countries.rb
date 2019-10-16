# frozen_string_literal: true

FactoryBot.define do
  factory :iso3166_part2_country do
    association :area, factory: :area
    sequence(:code) { |n| "ZZ-#{n}" }
  end
end
