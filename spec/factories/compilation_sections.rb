FactoryGirl.define do
  factory :compilation_section do
    association :format, factory: :section_format
    association :medium, factory: :compilation_medium

    factory :compilation_section_with_side do
      side 'A'
    end

    factory :compilation_section_with_tracks do
      transient do
        tracks_count 5
      end

      after(:create) do |compilation_section, elevator|
        create_list(:track, elevator.tracks_count, section: compilation_section)
      end
    end
  end
end
