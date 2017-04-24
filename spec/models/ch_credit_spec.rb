require 'rails_helper'
require 'shared_examples_for_credits'

RSpec.describe ChCredit, type: :model do
  it_behaves_like 'a credit' do
    let(:credit)           { FactoryGirl.create(:ch_credit) }
    let(:credit_with_job)  { FactoryGirl.create(:ch_credit_with_job) }
    let(:credit_with_role) { FactoryGirl.create(:ch_credit_with_role) }
    let(:owner_setter)      { 'compilation_head=' }    
  end
end
