# frozen_string_literal: true

FactoryBot.define do
  factory :import_order do
    sequence(:code) { |n| "code-no-#{n}" }
    state { 'pending' }
    association :import_queue, factory: :import_queue
    association :user, factory: :user

    factory :brainz_import_order, class: 'BrainzImportOrder' do
      code { SecureRandom.uuid.to_s }

      factory :brainz_release_import_order, class: 'BrainzReleaseImportOrder' do
        type { 'BrainzReleaseImportOrder' }
      end
    end

    factory :cover_art_import_order, class: 'CoverArtImportOrder' do
      code { SecureRandom.uuid.to_s }

      factory :cover_art_release_import_order, class: 'CoverArtReleaseImportOrder'
    end
  end
end
