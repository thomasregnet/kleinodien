FactoryGirl.define do
  factory :product_number_type do
    sequence(:name) { |n| "identifier type ##{n}" }
  end
end
