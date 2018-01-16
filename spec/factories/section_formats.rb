FactoryBot.define do
  factory :section_format do
    sequence(:name) { |n| "section format ##{n}" }
    sequence(:abbr) { |n| "sf ##{n}" }
  end
end
