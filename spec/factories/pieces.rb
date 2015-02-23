FactoryGirl.define do
  factory :piece do
    piece_head
    type 'Piece'

    factory :song, class: Song do
      type 'Song'
      association :head, factory: :song_head
    end

    factory :movie, class: Movie do
      type 'Movie'
      association :head, factory: :movie_head
    end
  end
end
