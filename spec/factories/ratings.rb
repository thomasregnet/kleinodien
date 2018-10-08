FactoryBot.define do
  factory :rating do
    value { 1 }
    association :user, factory: :user

    factory :artist_credit_rating do
      association :artist_credit, factory: :artist_credit
    end
  end
end
