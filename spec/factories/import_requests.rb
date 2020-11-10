# frozen_string_literal: true

FactoryBot.define do
  factory :import_request do
    sequence(:code) { |n| }

    factory :brainz_import_request, class: 'BrainzImportRequest' do
      sequence(:code) { SecureRandom.uuid.to_s }
      association :import_order, factory: :brainz_import_order

      factory :brainz_area_import_request, class: 'BrainzAreaImportRequest'
      factory :brainz_artist_import_request, class: 'BrainzArtistImportRequest'
      factory :brainz_label_import_request, class: 'BrainzLabelImportRequest'
      factory :brainz_release_group_import_request, class: 'BrainzReleaseGroupImportRequest'
      factory :brainz_release_import_request, class: 'BrainzReleaseImportRequest'

      factory :cover_art_import_request, class: 'CoverArtImportRequest' do
        sequence(:code) { SecureRandom.uuid.to_s }
        association :import_order, factory: :cover_art_import_order

        factory :cover_art_image_import_request, class: 'CoverArtImageImportRequest'
        factory :cover_art_release_manifest_import_request, class: 'CoverArtReleaseManifestImportRequest'
      end
    end
  end
end
