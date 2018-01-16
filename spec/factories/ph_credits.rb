FactoryBot.define do
  factory :ph_credit do
    artist_credit
    piece_head

    factory :ph_credit_with_role do
      role 'a PieceHead role'
    end

    factory :ph_credit_with_job do
      association :job, factory: :job
    end
  end
end
