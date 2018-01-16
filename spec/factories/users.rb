FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password 'topSecret'
    password_confirmation 'topSecret'
  end
end
