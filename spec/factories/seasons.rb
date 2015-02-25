FactoryGirl.define do
  factory :season do
    serial
    sequence(:no) { |n| n }
    type 'Season'

    factory :season_with_tv_episode_heads do
      association :serial, factory: :tv_serial
      transient do
        episodes_count 5
      end

      after(:create) do |season, elevator|
        create_list(:tv_episode_head, elevator.episodes_count, season: season)
      end
    end

    factory :zero_season, class: ZeroSeason do
      association :serial, factory: :podcast_serial
      no 0
      type 'ZeroSeason'
    end
  end
end
