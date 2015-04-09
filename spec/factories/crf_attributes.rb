FactoryGirl.define do
  factory :crf_attribute do
    association :format, factory: :cr_format
    association :kind,   factory: :crf_attribute_kind
    sequence(:no) { |n| n }
  end
end
