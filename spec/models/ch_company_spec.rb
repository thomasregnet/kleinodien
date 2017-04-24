require 'rails_helper'
require 'shared_examples_for_companies'

RSpec.describe ChCompany, type: :model do
  it_behaves_like 'a company' do
    #let(:factory)      { :ch_company }
    let(:company)      { FactoryGirl.create(:ch_company) }
    let(:owner_setter) { 'compilation_head=' }
  end
end
