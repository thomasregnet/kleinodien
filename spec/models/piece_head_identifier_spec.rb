require 'rails_helper'
require 'shared_examples_for_identifiers'

RSpec.describe PieceHeadIdentifier, type: :model do
  it_behaves_like 'an identifier' do
    let(:identifier) { FactoryGirl.build(:piece_head_identifier) }
  end

  it 'is not valid without a PieceHead' do
    identifier = FactoryGirl.build(:piece_head_identifier)
    identifier.piece_head = nil
    expect(identifier).not_to be_valid
  end
end
