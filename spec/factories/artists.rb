FactoryGirl.define do
  factory :artist do
    sequence(:name) { |n| "artist ##{n}" }

    factory :artist_brainz do
      source_name Source::MusicBrainz.name
      sequence(:source_ident) { |n| "looks-like-an-artist-uuid-#{n}" }
    end

    factory :artist_with_disambiguation do
      sequence(:disambiguation) { |n| "artist disambiguation ##{n}" }
    end
  end
end
