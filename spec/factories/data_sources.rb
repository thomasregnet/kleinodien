FactoryGirl.define do
  factory :data_source do
    sequence(:name) { |n| "data source #{n}" }
  end
end
