FactoryGirl.define do
  factory :serial do
    sequence(:title) { |n| "serial ##{n}" }
  end
end
