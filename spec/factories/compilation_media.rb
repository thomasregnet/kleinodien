FactoryGirl.define do
  factory :compilation_medium do
    association :release, factory: :compilation_release
    sequence(:no) { |n| n }
  end
end
