FactoryGirl.define do
  factory :track do
    association :release, factory: :piece_release

    # factory :track_heading, class: TrackHeading do
    #   association :compilation, factory: :compilation_release
    #   heading 'some heading'
    # end
    
    factory :track_with_compilation_release do
      association :compilation, factory: :compilation_release
    end

    factory :track_with_format do
      association :format, factory: :tr_format_kind
    end
  end
end
