require 'rails_helper'
require 'shared_examples_for_identifiers'
RSpec.describe ChIdentifier, type: :model do
  it_behaves_like 'an identifier' do
    let(:identifier) { FactoryGirl.build(:ch_identifier) }
  end

  it 'is not valid without a CompilationHead' do
    identifier = FactoryGirl.build(:ch_identifier)
    identifier.compilation_head = nil
    expect(identifier).not_to be_valid
  end
end
