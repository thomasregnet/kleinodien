FactoryBot.define do
  factory :artist_identifier do
    sequence(:value) { |n| "artist-identifier-#{n}" }
    association :artist, factory: :artist
    association :source, factory: :source
  end
end
