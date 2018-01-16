FactoryBot.define do
  factory :cr_company do
    company
    company_role
    compilation_release
    sequence(:catalog_no) { |n| "catalog-#{n}" }
  end
end
