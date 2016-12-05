FactoryGirl.define do
  factory :episode_head do
    season
    sequence(:position) { |n| n }
    sequence(:title) { |n| "episode title ##{n}" }
    type 'EpisodeHead'
    source Source::Omdb
    sequence(:source_ident) { |n| n.to_s }
  end
end
