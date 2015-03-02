FactoryGirl.define do
  factory :format do
    sequence(:name) { |n| "format ##{n}" }
  end
end
