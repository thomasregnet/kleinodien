FactoryGirl.define do
  factory :cr_format_clarification do
    association :format, factory: :cr_format
    format_kind
    no 1
  end

end
