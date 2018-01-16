FactoryBot.define do
  factory :artist_credit do
    sequence(:name) { |n| "artist credit ##{n}" }
    after(:create) do |ac|
      # after(:create) do |ac|
      # ac.participants << FactoryBot.build(:participant_without_artist_credit)
      # ac.participants << FactoryBot.create(:participant)
      ac.participants.build(artist: FactoryBot.create(:artist), position: 0)
      # ac.participants << FactoryBot.create(:participant_without_artist_credit)
    end

    # factory :artist_credit_with_data_supplier do
    # association :data_supplier, factory: :data_supplier
    # data_supplier
    # end
    factory :artist_credit_with_source do
      source Source::MusicBrainz
    end
  end
end
