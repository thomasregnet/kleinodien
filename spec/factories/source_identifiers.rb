FactoryGirl.define do
  factory :source_identifier do
    data_source
    sequence(:identifier) { |n| "abc_#{n}_defg" }
    type 'GenericSourceIdentifier'
  end

end
