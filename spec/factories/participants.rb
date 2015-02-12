FactoryGirl.define do
  factory :participant do
    no 0

    factory :participant_without_artist_credit do
      artist
    end
    
    factory :valid_participant do
      artist
      artist_credit FactoryGirl.build_stubbed(:artist_credit)
    end
  end
end
