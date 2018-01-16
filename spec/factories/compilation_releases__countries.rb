FactoryBot.define do
  factory :compilation_releases_country do
    sequence(:positoin) { |n| n }
    compilation_release
    country
  end
end
