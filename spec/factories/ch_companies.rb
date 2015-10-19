FactoryGirl.define do
  factory :ch_company do
    compilation_head
    company
    company_role
    sequence(:catalog_no) { |n| "catalog-##{n}" }
  end
end
