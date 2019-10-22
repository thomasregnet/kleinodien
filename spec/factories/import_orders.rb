# frozen_string_literal: true

FactoryBot.define do
  factory :import_order do
    sequence(:code) { |n| "code-no-#{n}" }
    state { 'pending' }
    association :user, factory: :user

    factory :brainz_import_order, class: 'BrainzImportOrder' do
      code { SecureRandom.uuid.to_s }

      factory :brainz_release_import_order, class: 'BrainzReleaseImportOrder' do
        type { 'BrainzReleaseImportOrder' }
      end
    end
  end
end
