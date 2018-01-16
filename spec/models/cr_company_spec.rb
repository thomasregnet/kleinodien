require 'rails_helper'
require 'shared_examples_for_companies'

RSpec.describe CrCompany, type: :model do
  it_behaves_like 'a company' do
    let(:company)      { FactoryBot.create(:cr_company) }
    let(:owner_setter) { 'compilation_release=' }
  end
end
