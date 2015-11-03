FactoryGirl.define do
  factory :crf_detail_kind do
    sequence(:name) { |n| "compilation release format attribute ##{n}" }
  end
end
