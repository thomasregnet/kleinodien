FactoryGirl.define do
  factory :compilation_identifier do
    association :release, factory: :compilation_release
    association :type, factory: :identifier_type
    sequence(:code) { |n| "code ##{n}" }
  end
end
