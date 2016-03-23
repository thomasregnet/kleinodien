require 'rails_helper'

RSpec.describe IdentifierType, type: :model do
  before(:each) do
    @id_type = FactoryGirl.create(:identifier_type)
  end

  it 'is valid with valid attributes' do
    expect(@id_type).to be_valid
  end

  it 'is not valid without a name' do
    @id_type.name = nil
    expect(@id_type).not_to be_valid
  end

  it 'must have a unique name' do
    other_id_type = IdentifierType.new(name: @id_type.name)
    expect(other_id_type).not_to be_valid

    regexp = /
      duplicate\s key\s value\s violates\s unique\s constraint
      \s
      "index_identifier_types_on_lower_name"
    /x
    expect { other_id_type.save! validate: false }.to raise_error(regexp)
  end

  it 'must have a case insensitive unique name' do
    other_id_type = IdentifierType.new(name: @id_type.name.upcase)
    expect(other_id_type).not_to be_valid

    regexp = /
      duplicate\s key\s value\s violates\s unique\s constraint
      \s
      "index_identifier_types_on_lower_name"
    /x
    expect { other_id_type.save! validate: false }.to raise_error(regexp)
  end
end
