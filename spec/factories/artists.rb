FactoryGirl.define do
  factory :artist do
    sequence(:name) { |n| "artist ##{n}" }

    factory :artist_with_disambiguation do
      sequence(:disambiguation) { |n| "artist disambiguation ##{n}" }
    end

    factory :artist_with_a_reference do
      association :reference, factory: :artist_reference
    end
  end
end
