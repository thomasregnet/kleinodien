FactoryGirl.define do
  factory :season do
    serial
    sequence(:no) { |n| n }
    type 'Season'

    factory :season_with_tv_episode_heads do
      transient do
        episodes_count 5
      end

      after(:create) do |season, elevator|
        create_list(:tv_episode_head, elevator.episodes_count, season: season)
      end
    end
  end
end
