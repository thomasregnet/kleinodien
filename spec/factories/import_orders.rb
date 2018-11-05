# frozen_string_literal: true

FactoryBot.define do
  factory :import_order do
    sequence(:code) { |n| "code-no-#{n}" }
    kind { 'some-kind' }
    state { 'pending' }
    association :user, factory: :user

    factory :brainz_import_order, class: 'BrainzImportOrder' do
      code { SecureRandom.uuid.to_s }
    end
  end
end
