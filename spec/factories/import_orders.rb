# frozen_string_literal: true

FactoryBot.define do
  factory :import_order do
    sequence(:code) { |n| "code-no-#{n}" }
    state { 'pending' }
    # association :import_queue, factory: :import_queue
    association :user, factory: :user

    factory :brainz_import_order, class: 'BrainzImportOrder' do
      code { SecureRandom.uuid.to_s }

      factory :brainz_release_import_order, class: 'BrainzReleaseImportOrder' do
      end
    end
  end
end
