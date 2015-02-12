FactoryGirl.define do
  factory :artist_credit do
    sequence(:name) { |n| "artist credit ##{n}" }
    after(:build) do |ac|
      ac.participants << FactoryGirl.build(:participant_without_artist_credit)
    end
  end
end
