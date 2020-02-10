# frozen_string_literal: true

FactoryBot.define do
  factory :episode_head_identifier do
    sequence(:value) { |n| "compilation-head-identifier-#{n}" }
    association :piece_head, factory: :episode_head
    association :source, factory: :source
  end
end
