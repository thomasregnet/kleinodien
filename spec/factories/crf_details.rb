# frozen_string_literal: true

FactoryBot.define do
  factory :crf_detail do
    association :format, factory: :cr_format
    association :kind,   factory: :crf_detail_kind
    sequence(:position) { |n| n }
  end
end
