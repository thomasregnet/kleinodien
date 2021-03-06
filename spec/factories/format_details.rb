# frozen_string_literal: true

FactoryBot.define do
  factory :format_detail do
    sequence(:abbr) { |n| "fdabbr#{n}" }
    sequence(:name) { |n| "format detail name #{n}" }
  end
end
