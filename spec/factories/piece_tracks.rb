FactoryBot.define do
  factory :piece_track do
    association :release, factory: :piece_release
  end
end
