FactoryGirl.define do
  factory :reference do
    association :supplier, factory: :data_supplier
    sequence(:identifier) { |n| "abc_#{n}_defg" }
    type 'GenericReference'

    factory :cr_reference, class: CrReference do
      type 'CrReference'
      sequence(:identifier) { |n| "abc_#{n}_defg" }
    end
  end

end
