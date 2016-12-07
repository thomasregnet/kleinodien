FactoryGirl.define do
  factory :cr_format do
    association :release, factory: :compilation_release
    #association :kind, factory: :cr_format_kind
    association :format, factory: :format
    quantity 1
    position 1

    factory :cr_format_with_details do
      transient do
        details_count 3
      end

      after(:create) do |cr_format, evaluator|
        create_list(
          :crf_detail,
          evaluator.details_count,
          format: cr_format
        )
      end
    end
  end
end
