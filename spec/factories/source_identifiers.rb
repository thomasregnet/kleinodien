FactoryGirl.define do
  factory :source_identifier do
    data_supplier
    sequence(:identifier) { |n| "abc_#{n}_defg" }
    type 'GenericSourceIdentifier'

    factory :cr_source_identifier, class: CrSourceIdentifier do
      type 'CrSourceIdentifier'
      sequence(:identifier) { |n| "abc_#{n}_defg" }
    end
  end

end
