FactoryGirl.define do
  factory :trf_attribute do
    association :track, factory: :track
    association :kind, factory: :trf_attribute_kind
    sequence(:no) { |n| n }
  end
end
