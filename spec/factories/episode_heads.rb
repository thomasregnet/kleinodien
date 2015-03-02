FactoryGirl.define do
  factory :episode_head do
    season
    sequence(:no) { |n| n }
    sequence(:title) { |n| "episode title ##{n}" }
    type 'EpisodeHead'
  end
end
