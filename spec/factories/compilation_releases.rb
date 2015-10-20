FactoryGirl.define do
  factory :compilation_release do
    association :head, factory: :compilation_head
    type "CompilationRelease"

    factory :compilation_release_with_companies do
      transient do
        companies_count 2
      end

      after(:create) do |compilation_release, evaluator|
        create_list(
          :cr_company,
          evaluator.companies_count,
          compilation_release: compilation_release
        )
      end
    end
    
    factory :compilation_release_with_credits do
      transient do
        credits_count 2
      end

      after(:create) do |compilation_release, evaluator|
        create_list(
          :cr_credit,
          evaluator.credits_count,
          compilation_release: compilation_release
        )
      end
    end

    # http://stackoverflow.com/questions/14444878/has-many-through-with-factory-girl
    factory :compilation_release_with_countries do
      after(:create) do |compilation_release|
        compilation_release.countries << FactoryGirl.create(:country)
        compilation_release.countries << FactoryGirl.create(:country)
      end
    end

    factory :compilation_release_with_labels do
      transient do
        labels_count 2
      end

      after(:create) do |compilation_release, evaluator|
        create_list(
          :cr_label,
          evaluator.labels_count,
          compilation_release: compilation_release
        )
      end
    end
  end
end
