# frozen_string_literal: true

FactoryBot.define do
  factory :tr_format_kind do
    sequence(:name) { |n| "format kind ##{n}" }
  end
end
