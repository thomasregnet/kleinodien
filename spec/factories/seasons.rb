FactoryGirl.define do
  factory :season do
    serial
    sequence(:no) { |n| n }
    type 'Season'

    factory :tv_season, class: TvSeason do
      type 'TvSeason'
    end
  end
end
