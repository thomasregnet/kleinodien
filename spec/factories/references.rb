FactoryGirl.define do
  factory :reference do
    data_supplier
    sequence(:identifier) { |n| "abc_#{n}_defg" }
    type 'GenericSourceIdentifier'

    factory :cr_reference, class: CrReference do
      type 'CrSourceIdentifier'
      sequence(:identifier) { |n| "abc_#{n}_defg" }
    end
  end

end
