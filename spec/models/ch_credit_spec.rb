require 'rails_helper'
require 'shared_examples_for_credits'

RSpec.describe ChCredit, type: :model do
  it_behaves_like 'a credit' do
    let(:factory)           { :ch_credit }
    let(:factory_with_job)  { :ch_credit_with_job }
    let(:factory_with_role) { :ch_credit_with_role }
    let(:owner_setter)      { 'compilation_head=' }
  end
end
