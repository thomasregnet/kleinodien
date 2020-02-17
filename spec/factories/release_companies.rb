# frozen_string_literal: true

FactoryBot.define do
  factory :release_company do
    association :company, factory: :company
    association :release, factory: :release
  end
end
