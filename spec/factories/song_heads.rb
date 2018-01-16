FactoryBot.define do
  factory :song_head do
    # season
    association :artist_credit, factory: :artist_credit
    sequence(:position) { |n| n }
    sequence(:title) { |n| "song title ##{n}" }
    type 'SongHead'

    factory :song_head_with_identifiers do
      transient do
        identifiers_count 2
      end

      after(:create) do |song_head, evaluator|
        create_list(
          :song_head_identifier,
          evaluator.identifiers_count,
          identified: song_head
        )
      end
    end
  end
end
