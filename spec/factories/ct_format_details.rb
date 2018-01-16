FactoryBot.define do
  factory :ct_format_detail do
    association :compilation_track, factory: :compilation_track
    association :detail, factory: :format_detail
    sequence(:position) { |n| n }
  end
end
