FactoryGirl.define do
  factory :compilation_head do
    sequence(:title) { |n| "compilation head ##{n}"}
    type 'CompilationHead'

    factory :album_head, class: AlbumHead do
      artist_credit
      type 'AlbumHead'
    end
  end
end
