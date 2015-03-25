FactoryGirl.define do
  factory :format_kind do
    sequence(:name) { |n| "format kind ##{n}" }
    type FormatKind
  end
end
