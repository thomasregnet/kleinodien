FactoryBot.define do
  factory :original_exemplar do
    association :compilation_release, factory: :album_release
    association :user, factory: :user
    sequence(:disambiguation) { |n| "my original #{n}" }
  end
end
