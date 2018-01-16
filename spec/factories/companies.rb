FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "company role ##{n}" }
  end
end
