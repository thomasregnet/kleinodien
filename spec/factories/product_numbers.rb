FactoryGirl.define do
  factory :product_number do
    association :release, factory: :compilation_release
    association :type, factory: :product_number_type
    sequence(:code) { |n| "code ##{n}" }
  end
end
