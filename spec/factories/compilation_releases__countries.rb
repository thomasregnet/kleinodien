FactoryGirl.define do
  factory :compilation_releases_country do
    sequence(:no) { |n| n }
    compilation_release
    country
  end
end
