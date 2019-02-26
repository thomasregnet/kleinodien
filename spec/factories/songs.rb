FactoryBot.define do
  factory :song do
    sequence(:title) { |n| "song release #{n}" }
    association :head, factory: :song_head
  end
end
