FactoryBot.define do
  factory :pr_company do
    piece_release
    company
    company_role
    sequence(:catalog_no) { |n| "catalog-##{n}" }
  end
end
