FactoryGirl.define do
  factory :compilation_head do
    sequence(:title) { |n| "compilation head ##{n}"}
    type 'CompilationHead'

    factory :compilation_head_with_companies do
      transient do
        companies_count 2
      end

      after(:create) do |compilation_head, evaluator|
        create_list(
          :ch_company,
          evaluator.companies_count,
          compilation_head: compilation_head
        )
      end
    end

    factory :compilation_head_with_countries do
      after(:create) do |compilation_head|
        compilation_head.countries << FactoryGirl.create(:country)
        compilation_head.countries << FactoryGirl.create(:country)
      end
    end
    
    factory :compilation_head_with_credits do
      transient do
        credits_count 2
      end

      after(:create) do |compilation_head, evaluator|
        create_list(
          :ch_credit,
          evaluator.credits_count,
          compilation_head: compilation_head
        )
      end
    end

    factory :compilation_head_with_labels do
      transient do
        labels_count 2
      end

      after(:create) do |compilation_head, evaluator|
        create_list(
          :ch_label,
          evaluator.labels_count,
          compilation_head: compilation_head
        )
      end
    end

    factory :compilation_head_with_a_reference do
      association :reference, factory: :ch_reference
    end

    factory :compilation_head_with_many_references do
      after(:create) do |compilation_head|
        compilation_head.references << FactoryGirl.create(:ch_reference)
        compilation_head.references << FactoryGirl.create(:ch_reference)
      end
    end

    factory :album_head, class: AlbumHead do
      artist_credit
      type 'AlbumHead'
    end
  end
end
