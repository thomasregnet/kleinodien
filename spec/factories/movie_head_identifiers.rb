FactoryBot.define do
  factory :movie_head_identifier do
    sequence(:value) { |n| "compilation-head-identifier-#{n}" }
    association :piece_head, factory: :movie_head
    association :source, factory: :source
  end
end
