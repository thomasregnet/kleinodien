FactoryBot.define do
  factory :song_release_identifier do
    sequence(:value) { |n| "song-release-identifier-#{n}" }
    association :identified, factory: :song_release
    association :source, factory: :source
  end
end
