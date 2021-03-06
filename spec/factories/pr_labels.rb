# frozen_string_literal: true

FactoryBot.define do
  factory :pr_label do
    piece
    company

    factory :pr_label_with_catalog_no do
      sequence(:catalog_no) { |n| "catalog-##{n}" }
    end
  end
end
