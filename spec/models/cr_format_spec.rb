require 'rails_helper'
require 'shared_examples_for_entities_with_format_details'

RSpec.describe CrFormat, type: :model do
  before(:each) do
    @cr_format = FactoryGirl.create(:cr_format)
  end

  it 'is valid with valid attributes' do
    expect(@cr_format).to be_valid
  end

  it 'has a note attribute' do
    expect(@cr_format).to respond_to(:note)
  end

  it 'is not valid without a release' do
    @cr_format.release = nil
    expect(@cr_format).not_to be_valid
    expect { @cr_format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
  end

  it 'is not valid without an format' do
    @cr_format.format = nil
    expect(@cr_format).not_to be_valid
    expect { @cr_format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
  end

  it 'is not valid without a quantity' do
    @cr_format.quantity = nil
    expect(@cr_format).not_to be_valid
    expect { @cr_format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
  end

  it 'is not valid without a no' do
    @cr_format.position = nil
    expect(@cr_format).not_to be_valid
    expect { @cr_format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
  end

  it 'must have a unique combination of release and postition' do
    clone = CrFormat.new do |c|
      c.release  = @cr_format.release
      c.position = @cr_format.position
      c.quantity = @cr_format.quantity
      c.format   = @cr_format.format
    end

    expect(clone).not_to be_valid
    expect { clone.save! validate: false }
      .to raise_error(/PG::UniqueViolation/)
  end

  context 'with details' do
    before(:each) do
      @cr_format = FactoryGirl.create(:cr_format_with_details)
    end

    it_behaves_like 'an entity with format_details' do
      let(:entity) { @cr_format }
    end

    it 'should handle its detalis' do
      expect(@cr_format).to respond_to(:details)
      expect(@cr_format.details.count).to eq(3)
    end
  end
end
