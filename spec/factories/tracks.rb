FactoryGirl.define do
  factory :track do
    association :release, factory: :piece_release
    format
  end
end
