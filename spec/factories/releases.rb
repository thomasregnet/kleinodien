# frozen_string_literal: true

FactoryBot.define do
  factory :release do
    head { association :release_head }
  end
end
