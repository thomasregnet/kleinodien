require 'rails_helper'
require 'shared_examples_for_credits'

RSpec.describe PrCredit, type: :model do
  it_behaves_like 'a credit' do
    let(:credit)           { FactoryGirl.create(:pr_credit) }
    let(:credit_with_job)  { FactoryGirl.create(:pr_credit_with_job) }
    let(:credit_with_role) { FactoryGirl.create(:pr_credit_with_role) }
    let(:owner_setter)     { 'piece_release=' }
  end
end
