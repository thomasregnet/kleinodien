# frozen_string_literal: true

FactoryBot.define do
  factory :script do
    sequence(:iso_code, 'a') { |n| "Xyz#{n}" }
    sequence(:name) { |n| "script_#{n}" }
  end
end
