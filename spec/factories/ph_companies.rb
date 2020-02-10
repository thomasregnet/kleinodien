# frozen_string_literal: true

FactoryBot.define do
  factory :ph_company do
    piece_head
    company
    company_role
    sequence(:catalog_no) { |n| "catalog-##{n}" }
  end
end
