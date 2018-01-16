FactoryBot.define do
  factory :album_head_identifier do
    sequence(:value) { |n| "album-head-identifier-#{n}" }
    association :identified, factory: :album_head
    association :source, factory: :source
  end
end
