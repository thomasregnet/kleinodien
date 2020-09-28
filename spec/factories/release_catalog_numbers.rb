# frozen_string_literal: true

FactoryBot.define do
  factory :release_catalog_number do
    sequence(:code) { |n| "code-#{n}" }
    association :release_company, factory: :release_company
  end
end
