FactoryGirl.define do
  factory :cr_format do
    association :release, factory: :compilation_release
    association :kind, factory: :cr_format_kind
    quantity 1
    no 1

    factory :cr_format_with_format_attributes do
      transient do
        attributes_count 3
      end

      after(:create) do |cr_format, evaluator|
        create_list(
          :crf_attribute,
          evaluator.attributes_count,
          format: cr_format
        )
      end
    end
  end
end
