FactoryGirl.define do
  factory :repository_position do

    factory :repository_position_with_compilation_track do
      association :compilation_track,
                  factory: :compilation_track_with_compilation_release
      association :user, factory: :user

      after(:build) do |r_pos|
        user = FactoryGirl.create(:user)
        r_pos.repository = FactoryGirl.create(:repository, user: r_pos.user)
      end
    end
  end
end
