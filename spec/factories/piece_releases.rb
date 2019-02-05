# frozen_string_literal: true

FactoryBot.define do
  factory :piece_release do
    association :piece, factory: :piece
  end
end
