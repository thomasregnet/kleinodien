FactoryGirl.define do
  factory :song_head_identifier do
    sequence(:value) { |n| "compilation-head-identifier-#{n}" }
    association :piece_head, factory: :song_head
    association :source, factory: :source
  end
end
