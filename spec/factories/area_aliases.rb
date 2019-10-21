# frozen_string_literal: true

FactoryBot.define do
  factory :area_alias do
    association :area, factory: :area
    sequence(:name) { |n| "area#{n}" }
  end
end
