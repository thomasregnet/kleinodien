require 'rails_helper'
require 'shared_examples_for_companies'

RSpec.describe PhCompany, type: :model do
  it_behaves_like 'a company' do
    let(:factory)      { :ph_company }
    let(:owner_setter) { 'piece_head=' }
  end
end
