FactoryGirl.define do
  factory :artist do
    sequence(:name) { |n| "artist ##{n}" }

    factory :artist_with_disambiguation do
      sequence(:disambiguation) { |n| "artist disambiguation ##{n}" }
    end

    factory :artist_with_a_reference do
      association :reference, factory: :artist_reference
    end

    factory :artist_with_many_references do
      after(:create) do |artist|
        2.times do
          artist.references << FactoryGirl.create(:artist_reference)
        end
        # artist.references << FactoryGirl.create(:artist_reference)
        # artist.references << FactoryGirl.create(:artist_reference)
      end
    end
  end
end
