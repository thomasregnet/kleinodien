# frozen_string_literal: true

FactoryBot.define do
  factory :iso3166_part3_country do
    association :area, factory: :area
    sequence(:code, 'AA') { |n| "AA#{n}" }
  end
end
