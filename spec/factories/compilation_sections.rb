FactoryGirl.define do
  factory :compilation_section do
    association :format, factory: :section_format
    association :medium, factory: :compilation_medium
    sequence(:no) { |n| n }

    factory :compilation_section_with_side do
      side 'A'
    end
  end
end
