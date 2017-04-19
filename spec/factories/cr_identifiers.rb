FactoryGirl.define do
  factory :cr_identifier do
    sequence(:value) { |n| "compilation-release-identifier-#{n}" }
    association :compilation_release, factory: :compilation_release
    association :source, factory: :source
    type CrIdentifier
  end
end
