FactoryGirl.define do
  factory :compilation_head do
    sequence(:title) { |n| "compilation head ##{n}"}
    type 'CompilationHead'

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

      after(:create) do |compilation_head, elevator|
        create_list(
          :ch_credit,
          elevator.credits_count,
          compilation_head: compilation_head
        )
      end
    end
        
    factory :album_head, class: AlbumHead do
      artist_credit
      type 'AlbumHead'
    end
  end
end
