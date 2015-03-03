FactoryGirl.define do
  factory :identifier_type do
    sequence(:name) { |n| "identifier type ##{n}" }
  end
end
