FactoryBot.define do
  factory :import_order do
    sequence(:code) { |n| "code-no-#{n}" }
    kind { 'some-kind'}
    association :user, factory: :user
  end
end
