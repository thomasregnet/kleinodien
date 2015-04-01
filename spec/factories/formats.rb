FactoryGirl.define do
  factory :format do
    sequence(:name) { |n| "format kind ##{n}" }
    type Format
  end
end
