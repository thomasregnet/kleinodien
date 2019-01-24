require 'rails_helper'
require 'shared_examples_for_credits'

RSpec.describe PrCredit, type: :model do
  it_behaves_like 'a credit' do
    let(:credit)           { FactoryBot.create(:pr_credit) }
    let(:credit_with_job)  { FactoryBot.create(:pr_credit_with_job) }
    let(:credit_with_role) { FactoryBot.create(:pr_credit_with_role) }
    let(:owner_setter)     { 'piece=' }
  end
end
