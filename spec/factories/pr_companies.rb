FactoryBot.define do
  factory :pr_company do
    piece
    company
    company_role
    sequence(:catalog_no) { |n| "catalog-##{n}" }
  end
end
