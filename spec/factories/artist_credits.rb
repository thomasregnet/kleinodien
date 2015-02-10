FactoryGirl.define do
  factory :artist_credit do
    sequence(:name) { |n| "artist credit ##{n}" }
  end
end
