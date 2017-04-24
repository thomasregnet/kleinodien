require 'rails_helper'
require 'shared_examples_for_unique_names'

RSpec.describe CompanyRole, type: :model do
  it_behaves_like 'an entity with an unique name' do
    let(:candidate) { FactoryGirl.build(:company_role) }
  end
end
