FactoryBot.define do
  factory :ch_credit do
    artist_credit
    compilation_head

    factory :ch_credit_with_role do
      role { 'a role' }
    end

    factory :ch_credit_with_job do
      association :job, factory: :job
    end
  end
end
