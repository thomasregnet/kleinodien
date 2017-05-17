FactoryGirl.define do
  factory :job do
    sequence(:name) { |n| "job ##{n}" }
  end
end
