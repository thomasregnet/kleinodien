FactoryGirl.define do
  factory :participant do
    sequence(:no) { |n| n }

    factory :participant_without_artist_credit do
      artist
    end
    
    factory :valid_participant do
      artist
      artist_credit
    end
  end
end
