# frozen_string_literal: true

FactoryBot.define do
  factory :heap_head do
    sequence(:title) { |n| "HeapHead ##{n}" }

    factory :album_head, class: AlbumHead do
      association :artist_credit, factory: :artist_credit
    end
  end
end
