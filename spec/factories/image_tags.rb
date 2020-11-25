# frozen_string_literal: true

FactoryBot.define do
  factory :image_tag do
    sequence(:name) { |n| "image_tag_#{n}"}
  end
end
