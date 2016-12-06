FactoryGirl.define do
  factory :format do
    sequence(:abbr) { |n| "fabbr#{n}" }
    sequence(:name) { |n| "format name #{n}" }
  end
end
