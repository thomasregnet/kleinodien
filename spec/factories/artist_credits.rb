FactoryBot.define do
  factory :artist_credit do
    sequence(:name) { |n| "artist credit ##{n}" }
    after(:create) do |ac|
      ac.participants.build(artist: FactoryBot.create(:artist), position: 0)
    end
  end
end
