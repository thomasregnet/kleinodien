# frozen_string_literal: true

FactoryBot.define do
  factory :track_detail_kind do
    sequence(:name) { |n| "track detail ##{n}" }
  end
end
