require 'rails_helper'
require 'shared_examples_for_companies'

RSpec.describe PrCompany, type: :model do
  it_behaves_like 'a company' do
    let(:factory)      { :pr_company }
    let(:owner_setter) { 'piece_release=' }
  end
end
