FactoryGirl.define do
  factory :piece_head do
    sequence(:title) { |n| "piece ##{n}" }
    type  'PieceHead'

    factory :song_head, class: SongHead do
      artist_credit
      type 'SongHead'
    end

    factory :movie_head, class: MovieHead do
      type 'MovieHead'
    end
  end
end
