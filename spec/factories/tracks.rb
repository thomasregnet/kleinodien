FactoryGirl.define do
  factory :track do
    association :release, factory: :piece_release
    format

    factory :track_with_compilation_release do
      association :compilation, factory: :compilation_release
    end
    # factory :track_with_section do
    #   association :section, factory: :compilation_section
    # end
  end
end
