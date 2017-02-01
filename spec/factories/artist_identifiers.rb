FactoryGirl.define do
  factory :artist_identifier do
    sequence(:value) { |n| "artist-identifier-#{n}" }
    association :source, factory: :source

    factory :artist_identifier_with_artist do
      association :artist, factory: :artist
    end
  end
end
