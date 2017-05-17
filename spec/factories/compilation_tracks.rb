FactoryGirl.define do
  factory :compilation_track do
    association :piece_release, factory: :piece_release
    association :compilation_release, factory: :compilation_release

    factory :compilation_track_with_compilation_release do
      association :compilation_release, factory: :compilation_release
    end

    factory :compilation_track_with_duration do
      association :duration, factory: :duration
    end

    factory :compilation_track_with_format do
      association :format, factory: :format

      factory :compilation_track_with_details do
        transient do
          details_count 3
        end

        after(:create) do |track, evaluator|
          create_list(
            :ct_format_detail,
            evaluator.details_count,
            compilation_track: track
          )
        end
      end
    end

    factory :compilation_track_with_repository_positions do
      transient do
        positions_count 3
      end

      after(:create) do |track, _evaluator|
        3.times do
          track.repository_positions << create(
            :repository_position_with_compilation_track,
            compilation_track: track
          )
        end
      end
    end
  end
end
