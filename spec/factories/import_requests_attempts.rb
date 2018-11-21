# frozen_string_literal: true

FactoryBot.define do
  factory :import_request_attempt do
    status_code { 200 }
    association :import_request, factory: :brainz_artist_import_request
  end
end
