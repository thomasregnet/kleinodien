require 'rails_helper'

RSpec.describe SourceIdentifier, type: :model do
  before(:each) do
    @src_ident = FactoryGirl.create(:source_identifier)
  end

  it 'is valid with valid attributes' do
    expect(@src_ident).to be_valid
  end

  describe 'without a DataSource' do
    before(:each) do
      @src_ident.data_source = nil
    end

    it 'is not valid' do
      expect(@src_ident).not_to be_valid
      expect { @src_ident.save! validate: false }
        .to raise_error(/PG::NotNullViolation:.+"data_source_id".+not-null/)
    end
  end

  describe 'without a identifier' do
    before(:each) do
      @src_ident.identifier = nil
    end

    it 'is not valid' do
      expect(@src_ident).not_to be_valid
      expect { @src_ident.save! validate: false }
        .to raise_error(/PG::NotNullViolation:.+"identifier".+not-null/)
    end
  end

  describe 'with a blank identifier' do
    before(:each) do
      @src_ident.identifier = ''
    end

    it 'is not valid' do
      expect(@src_ident).not_to be_valid
    end
  end

    describe 'without a type' do
    before(:each) do
      @src_ident.type = nil
    end

    it 'is not valid' do
      expect(@src_ident).not_to be_valid
      expect { @src_ident.save! validate: false }
        .to raise_error(/PG::NotNullViolation:.+"type".+not-null/)
    end
  end

  describe 'with a blank type' do
    before(:each) do
      @src_ident.type = ''
    end

    it 'is not valid' do
      expect(@src_ident).not_to be_valid
    end
  end
end
