# frozen_string_literal: true

FactoryBot.define do
  factory :piece_track do
    association :piece, factory: :piece
  end
end
