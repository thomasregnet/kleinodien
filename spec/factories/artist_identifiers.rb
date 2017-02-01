FactoryGirl.define do
  factory :artist_identifier do
    sequence(:value) { |n| "artist-identifier-#{n}" }
    association :source, factory: :source
  end
end
