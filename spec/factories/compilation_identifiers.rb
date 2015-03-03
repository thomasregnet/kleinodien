FactoryGirl.define do
  factory :compilation_identifier do
    compilation_release
    identifier_type
    sequence(:code) { |n| "code ##{n}" }
  end
end
