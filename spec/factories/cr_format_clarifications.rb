FactoryGirl.define do
  factory :cr_format_clarification do
    association :format, factory: :cr_format
    association :kind, factory: :format
    sequence(:no) { |n| n }
  end
end
