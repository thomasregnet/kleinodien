FactoryBot.define do
  factory :station do
    sequence(:name) { |n| "station ##{n}" }
    type 'Station'
  end
end
