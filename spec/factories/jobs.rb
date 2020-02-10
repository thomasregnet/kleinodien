# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    sequence(:name) { |n| "job ##{n}" }
  end
end
