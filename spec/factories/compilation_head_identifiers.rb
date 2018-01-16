FactoryBot.define do
  factory :compilation_head_identifier do
    sequence(:value) { |n| "compilation-head-identifier-#{n}" }
    association :compilation_head, factory: :compilation_head
    association :source, factory: :source
  end
end
