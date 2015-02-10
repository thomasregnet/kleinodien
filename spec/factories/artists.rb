FactoryGirl.define do
  factory :artist do
    sequence(:name) { |n| "artist ##{n}" }

    factory :artist_with_disambiguation do
      sequence(:disambiguation) { |n| "artist disambiguation ##{n}" }
    end
  end
end
