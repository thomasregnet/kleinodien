FactoryGirl.define do
  factory :season do
    serial
    no 1
    type 'Season'

    factory :regular_season, class: RegularSeason do
      type 'RegularSeason'
    end
  end
end
