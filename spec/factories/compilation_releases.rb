FactoryGirl.define do
  factory :compilation_release do
    association :head, factory: :compilation_head
    type "CompilationRelease"

    factory :compilation_release_with_companies do
      transient do
        companies_count 2
      end

      after(:create) do |compilation_release, elevator|
        create_list(
          :cr_company,
          elevator.companies_count,
          compilation_release: compilation_release
        )
      end
    end
  end
end
