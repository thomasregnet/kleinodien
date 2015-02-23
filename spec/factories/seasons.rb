FactoryGirl.define do
  factory :season do
    serial
    no 1
    type 'Season'

    factory :tv_season, class: TvSeason do
      type 'TvSeason'
    end
  end
end
