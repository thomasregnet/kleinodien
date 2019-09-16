# frozen_string_literal: true

FactoryBot.define do
  factory :release do
    association :head, factory: :release_head
  end
end
