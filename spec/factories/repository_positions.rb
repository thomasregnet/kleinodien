FactoryBot.define do
  factory :repository_position do
    association :user, factory: :user

    factory :repository_position_with_compilation_track do
      association :compilation_track,
                  factory: :compilation_track_with_compilation_release
      association :user, factory: :user

      after(:build) do |r_pos|
        r_pos.repository = create(:repository, user: r_pos.user)
        r_pos.compilation_copy = create(
          :compilation_copy,
          user:    r_pos.user,
          # release: r_pos.compilation_track.compilation
          release: r_pos.compilation_track.compilation_release
        )
      end
    end

    factory :repository_position_with_piece_track do
      association :piece_track, factory: :piece_track

      after(:build) do |r_pos|
        r_pos.repository = create(:repository, user: r_pos.user)
      end
    end
  end
end
