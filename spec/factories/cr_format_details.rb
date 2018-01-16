FactoryBot.define do
  factory :cr_format_detail do
    association :format, factory: :cr_format
    association :detail, factory: :format_detail
    sequence(:position) { |n| n }
  end
end
