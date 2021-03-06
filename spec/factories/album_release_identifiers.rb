# frozen_string_literal: true

FactoryBot.define do
  factory :album_release_identifier do
    sequence(:value) { |n| "album-release-identifier-#{n}" }
    association :identified, factory: :album_release
    association :source, factory: :source
  end
end
