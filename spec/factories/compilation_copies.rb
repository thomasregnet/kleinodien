FactoryBot.define do
  factory :compilation_copy do
    association :release, factory: :compilation_release
    association :user, factory: :user
  end
end
