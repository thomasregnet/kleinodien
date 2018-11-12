# frozen_string_literal: true

FactoryBot.define do
  factory :import_request do
    sequence(:code) { |n| }
    # association :import_order, factory: :import_order

    factory(
      :brainz_release_import_request,
      class: 'BrainzReleaseImportRequest'
    ) do
      association :import_order, factory: :brainz_import_order
    end
  end
end
