FactoryGirl.define do
  factory :track_detail do
    association :track, factory: :compilation_track
    association :kind, factory: :track_detail_kind
    sequence(:no) { |n| n }
  end
end
