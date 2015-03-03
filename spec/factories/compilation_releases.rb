FactoryGirl.define do
  factory :compilation_release do
    association :head, factory: :compilation_head
    type "CompilationRelease"
  end
end
