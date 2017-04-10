FactoryGirl.define do
  factory :cr_identifier do
    sequence(:value) { |n| "compilation-head-identifier-#{n}" }
    association :compilation_release, factory: :compilation_release
    association :source, factory: :source
  end
end
