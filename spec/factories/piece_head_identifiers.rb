FactoryBot.define do
  factory :piece_head_identifier do
    sequence(:value) { |n| "album-head-identifier-#{n}" }
    association :identified, factory: :piece_head
    association :source, factory: :source
  end
end
