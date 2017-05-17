FactoryGirl.define do
  factory :comment do
    sequence(:text) { |n| "this is comment #{n}" }
    association :user, factory: :user

    factory :comment_on_artist do
      association :artist, factory: :artist
    end
  end
end
