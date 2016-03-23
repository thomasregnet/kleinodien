require 'rails_helper'
require 'shared_examples_for_credits'

RSpec.describe PhCredit, type: :model do
  it_behaves_like 'a credit' do
    let(:factory)           { :ph_credit }
    let(:factory_with_job)  { :ph_credit_with_job }
    let(:factory_with_role) { :ph_credit_with_role }
    let(:owner_setter)      { 'piece_head=' }
  end
end
