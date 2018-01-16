FactoryBot.define do
  factory :compilation_head do
    sequence(:title) { |n| "compilation head ##{n}" }
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
        compilation_head.countries << FactoryBot.create(:country)
        compilation_head.countries << FactoryBot.create(:country)
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

    factory :album_head, class: AlbumHead do
      artist_credit
      type 'AlbumHead'

      factory :album_head_with_identifiers do
        transient do
          identifiers_count 2
        end

        after(:create) do |album_head, evaluator|
          create_list(
            :album_head_identifier,
            evaluator.identifiers_count,
            identified: album_head
          )
        end
      end
    end
  end
end
