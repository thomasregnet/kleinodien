FactoryBot.define do
  factory :brainz_release_import_request do
    sequence(:code) { SecureRandom.uuid }
  end
end
