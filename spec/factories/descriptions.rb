FactoryBot.define do
  factory :description do
    text 'a nice description'

    factory :artist_credit_description do
      association :artist_credit, factory: :artist_credit
    end
  end
end
