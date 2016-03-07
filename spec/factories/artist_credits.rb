FactoryGirl.define do
  factory :artist_credit do
    sequence(:name) { |n| "artist credit ##{n}" }
    after(:build) do |ac|
      ac.participants << FactoryGirl.build(:participant_without_artist_credit)
    end

    factory :artist_credit_with_data_supplier do
      #association :data_supplier, factory: :data_supplier
      data_supplier
    end
  end
end
