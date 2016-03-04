FactoryGirl.define do
  factory :reference do
    association :supplier, factory: :data_supplier
    sequence(:identifier) { |n| "abc_#{n}_defg" }
    type 'GenericReference'

    factory :artist_reference, class: ArtistReference do
      type 'ArtistReference'
      sequence(:identifier) { |n| "abc_#{n}_defg" }
    end

    factory :ch_reference, class: ChReference do
      type 'ChReference'
      sequence(:identifier) { |n| "abc_#{n}_defg" }
    end

    factory :cr_reference, class: CrReference do
      type 'CrReference'
      sequence(:identifier) { |n| "abc_#{n}_defg" }
    end

    factory :ph_reference, class: PhReference do
      type 'PhReference'
      sequence(:identifier) { |n| "abc_#{n}_defg" }
    end

    factory :pr_reference, class: PrReference do
      type 'PrReference'
      sequence(:identifier) { |n| "abc_#{n}_defg" }
    end    
  end

 end
