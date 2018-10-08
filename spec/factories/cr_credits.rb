FactoryBot.define do
  factory :cr_credit do
    artist_credit
    compilation_release

    factory :cr_credit_with_role do
      role { 'a role' }
    end

    factory :cr_credit_with_job do
      association :job, factory: :job
    end
  end
end
