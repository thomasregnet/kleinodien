# frozen_string_literal: true

FactoryBot.define do
  factory :set_head do
    sequence(:title) { |n| "SetHead ##{n}" }
  end
end
