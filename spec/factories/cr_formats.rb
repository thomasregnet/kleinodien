FactoryGirl.define do
  factory :cr_format do
    association :release, factory: :compilation_release
    association :format_kind, factory: :format_kind
    quantity 1
    no 1

    factory :cr_format_with_clarifications do
      transient do
        clarifications_count 3
      end

      after(:create) do |cr_format, evaluator|
        create_list(
          :cr_format_clarification,
          evaluator.clarifications_count,
          format: cr_format
        )
      end
    end
  end
end
