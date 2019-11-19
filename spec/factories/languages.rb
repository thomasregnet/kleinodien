FactoryBot.define do
  factory :language do
    sequence(:name) { |n| "language_#{n}" }
  end
end
