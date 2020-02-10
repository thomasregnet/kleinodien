# frozen_string_literal: true

FactoryBot.define do
  factory :data_import do
    sequence(:note) { |n| "data import #{n}" }
  end
end
