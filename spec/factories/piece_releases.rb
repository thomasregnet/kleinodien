FactoryGirl.define do
  factory :piece_release do
    piece_head
    type 'Piece'

    factory :song_release, class: SongRelease do
      type 'Song'
      association :head, factory: :song_head
    end

    factory :movie_release, class: MovieRelease do
      type 'Movie'
      association :head, factory: :movie_head
    end
  end
end
