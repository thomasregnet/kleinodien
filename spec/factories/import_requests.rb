# frozen_string_literal: true

FactoryBot.define do
  factory :import_request do
    sequence(:code) { |n| }

    factory(
      :brainz_release_import_request,
      class: 'BrainzReleaseImportRequest'
    ) do
      sequence(:code) { SecureRandom.uuid.to_s }
      association :import_order, factory: :brainz_import_order
    end
  end
end
