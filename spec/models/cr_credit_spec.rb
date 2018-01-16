require 'rails_helper'
require 'shared_examples_for_credits'

RSpec.describe CrCredit, type: :model do
  it_behaves_like 'a credit' do
    let(:credit)           { FactoryBot.create(:cr_credit) }
    let(:credit_with_job)  { FactoryBot.create(:cr_credit_with_job) }
    let(:credit_with_role) { FactoryBot.create(:cr_credit_with_role) }
    let(:owner_setter) { 'compilation_release=' }
  end
end
