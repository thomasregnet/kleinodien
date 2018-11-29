FactoryBot.define do
  factory :import_request_body do
    sequence(:content) { |n| "body #{n}" }
    association :import_request, factory: :brainz_artist_import_request
  end
end
