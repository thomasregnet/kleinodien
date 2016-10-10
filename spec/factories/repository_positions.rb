FactoryGirl.define do
  factory :repository_position do

    factory :repository_position_with_compilation_track do
      association :compilation_track,
                  factory: :compilation_track_with_compilation_release
      association :user, factory: :user
    end
  end
end
