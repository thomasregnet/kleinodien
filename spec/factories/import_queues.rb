# frozen_string_literal: true

FactoryBot.define do
  factory :import_queue do
    sequence(:name) { |n| "import_queue_no_#{n}" }
  end
end
