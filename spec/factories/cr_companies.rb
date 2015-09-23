FactoryGirl.define do
  factory :cr_company do
    company
    company_role
    sequence(:catalog_no) { |n| "catalog-#{n}" }
  end

end
