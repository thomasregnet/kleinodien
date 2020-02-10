# frozen_string_literal: true

FactoryBot.define do
  factory :data_supplier do
    sequence(:name) { |n| "data supplier #{n}" }
  end
end
