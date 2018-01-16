FactoryBot.define do
  factory :compilation_track_detail do
    association :track, factory: :compilation_track
    association :detail, factory: :format_detail
    sequence(:position) { |n| n }
  end
end
