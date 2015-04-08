FactoryGirl.define do
  factory :trf_attribute_kind do
    sequence(:name) { |n| "format attribute ##{n}" }
  end
end
