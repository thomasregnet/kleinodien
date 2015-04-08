FactoryGirl.define do
  factory :tr_format_kind do
    sequence(:name) { |n| "format kind ##{n}" }
  end
end
