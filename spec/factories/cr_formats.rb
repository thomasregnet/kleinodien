FactoryGirl.define do
  factory :cr_format do
    association :release, factory: :compilation_release
    association :format_kind, factory: :format_kind
    quantity 1
    no 1
  end

end
