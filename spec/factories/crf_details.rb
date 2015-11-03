FactoryGirl.define do
  factory :crf_detail do
    association :format, factory: :cr_format
    association :kind,   factory: :crf_detail_kind
    sequence(:no) { |n| n }
  end
end
