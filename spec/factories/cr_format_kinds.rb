FactoryGirl.define do
  factory :cr_format_kind do
    sequence(:name) { |n| "compilation release format kind ##[n]" }
  end
end
