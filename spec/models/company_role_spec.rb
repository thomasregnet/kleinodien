# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_unique_names'

RSpec.describe CompanyRole, type: :model do
  it_behaves_like 'an entity with an unique name' do
    let(:candidate) { FactoryBot.build(:company_role) }
  end

  subject { FactoryBot.build(:company_role) }

  it { should have_many(:release_companies) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_presence_of(:name) }
end
