FactoryGirl.define do
  factory :compilation_track do
    association :release, factory: :piece_release
    association :compilation, factory: :compilation_release

    factory :compilation_track_with_compilation_release do
      association :compilation, factory: :compilation_release
    end

    factory :compilation_track_with_duration do
      association :duration, factory: :duration
    end

    factory :compilation_track_with_format do
      association :format, factory: :tr_format_kind
    end

    factory :compilation_track_with_details do
      transient do
        details_count 3
      end

      after(:create) do |track, evaluator|
        create_list(
          :compilation_track_detail,
          evaluator.details_count,
          track: track
        )
      end
    end

    factory :compilation_track_with_repository_positions do
      transient do
        positions_count 3
      end

      # TODO: refactor factory :compilation_track_with_repository_positions
      after(:create) do |track, evaluator|
        3.times do
          user = FactoryGirl.create(:user)
          repository = FactoryGirl.create(:repository, user: user)
          track.repository_positions << FactoryGirl.create(
            :repository_position,
            compilation_copy: FactoryGirl.create(
              :compilation_copy,
              user: user,
              release: track.compilation
            ),
            compilation_track: track,
            repository: repository,
            user: user
          )
        end
      end
    end
  end
end
