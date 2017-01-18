FactoryGirl.define do
  factory :comment do
    sequence(:text) { |n| "this is comment #{n}" }
    association :user, factory: :user

    factory :comment_on_artist_credit do
      association :artist_credit, factory: :artist_credit
    end
  end
end
  
