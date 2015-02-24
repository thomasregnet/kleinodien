FactoryGirl.define do
  factory :season do
    serial
    sequence(:no) { |n| n }
    type 'Season'
  end
end
