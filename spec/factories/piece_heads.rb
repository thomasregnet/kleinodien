FactoryGirl.define do
  factory :piece_head do
    sequence(:title) { |n| "piece ##{n}" }
    type  'PieceHead'

    factory :song_head, class: SongHead do
      artist_credit
      type 'SongHead'
    end
  end
end
