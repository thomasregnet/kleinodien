FactoryGirl.define do
  factory :track do
    association :release, factory: :piece_release

    factory :track_with_compilation_release do
      association :compilation, factory: :compilation_release
    end
  end
end
