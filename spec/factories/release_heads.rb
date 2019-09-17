# frozen_string_literal: true

FactoryBot.define do
  factory :release_head do
    sequence(:title) { |n| "ReleaseHead ##{n}" }

    factory :album_head, class: AlbumHead do
      association :artist_credit, factory: :artist_credit
    end
  end
end
