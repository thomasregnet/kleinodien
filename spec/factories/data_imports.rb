FactoryGirl.define do
  factory :data_import do
    sequence(:note) { |n| "data import #{n}" }
  end
end
