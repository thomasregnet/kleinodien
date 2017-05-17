FactoryGirl.define do
  factory :pr_credit do
    artist_credit
    piece_release

    factory :pr_credit_with_role do
      role 'a PieceReleaseRole'
    end

    factory :pr_credit_with_job do
      association :job, factory: :job
    end
  end
end
