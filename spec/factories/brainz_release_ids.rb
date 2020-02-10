# frozen_string_literal: true

FactoryBot.define do
  factory :brainz_release_id do
    initialize_with { new(SecureRandom.uuid) }
  end
end
