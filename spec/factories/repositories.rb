FactoryGirl.define do
  factory :repository do
    sequence(:name) { |n| "repository #{n}" }
    association :user, factory: :user
  end
end
