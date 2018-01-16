FactoryBot.define do
  factory :company_role do
    sequence(:name) { |n| "company role ##{n}" }
  end
end
