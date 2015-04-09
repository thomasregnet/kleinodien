FactoryGirl.define do
  factory :crf_attribute_kind do
    sequence(:name) { |n| "compilation release format attribute ##{n}" }
  end
end
