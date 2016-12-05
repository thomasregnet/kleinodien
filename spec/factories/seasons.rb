FactoryGirl.define do
  factory :season do
    serial
    sequence(:position) { |n| n }

    factory :season_with_tv_episode_heads do
      association :serial, factory: :tv_serial
      transient do
        episodes_count 5
      end

      after(:create) do |season, evaluator|
        create_list(:tv_episode_head, evaluator.episodes_count, season: season)
      end
    end
  end
end
