FactoryBot.define do
  factory :medium_format do
    sequence(:name) { |n| "format #{n}" }

    factory :medium_format_with_brainz_code do
      sequence(:brainz_code) { SecureRandom.uuid.to_s }
    end
  end
end
