FactoryGirl.define do
  # TODO: maybe delete this factory
  factory :participant do
    sequence(:position) { |n| n }

    # factory :participant_without_artist_credit do
    #   artist
    # end
    
    # factory :valid_participant do
    #   association :artist, factory: :artist
    #   #association :artist_credit, factory: :artist_credit
    # end
  end
end
