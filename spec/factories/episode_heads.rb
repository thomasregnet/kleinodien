FactoryGirl.define do
  factory :episode_head do
    season
    sequence(:no) { |n| n }
    sequence(:title) { |n| "episode title ##{n}" }
    type 'EpisodeHead'
    source_name Source::Omdb.name
    sequence(:source_ident) { |n| n.to_s }
  end
end
