# frozen_string_literal: true

FactoryBot.define do
  factory :release do
    # association :head, factory: :release_head
    # head factory: :release_head
    head { association :release_head }
  end
end
