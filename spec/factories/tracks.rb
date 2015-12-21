FactoryGirl.define do
  factory :track do
    association :release, factory: :piece_release

    factory :track_with_compilation_release do
      association :compilation, factory: :compilation_release
    end

    factory :track_with_duration do
      association :duration, factory: :duration
    end

    factory :track_with_format do
      association :format, factory: :tr_format_kind
    end

    factory :track_with_details do
      transient do
        details_count 3
      end

      after(:create) do |track, evaluator|
        create_list(:track_detail, evaluator.details_count, track: track)
      end
    end
  end
end
