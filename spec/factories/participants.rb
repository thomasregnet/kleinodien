FactoryGirl.define do
  factory :participant do
    no 0
    artist
    artist_credit FactoryGirl.build_stubbed(:artist_credit)
  end
end
