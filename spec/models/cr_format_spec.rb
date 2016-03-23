require 'rails_helper'

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

  it 'is not valid without a kind' do
    @cr_format.kind = nil
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
    @cr_format.no = nil
    expect(@cr_format).not_to be_valid
    expect { @cr_format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
  end

  it 'must have a unique combination of release and no' do
    clone = CrFormat.new do |c|
      c.release  = @cr_format.release
      c.no       = @cr_format.no
      c.quantity = @cr_format.quantity
      c.kind     = @cr_format.kind
    end
    expect(clone).not_to be_valid

    regexp = %r{
      duplicate\s key
      .+
      violates\s unique\s constraint
      \s
      "index_cr_formats_on_compilation_release_id_and_no"
    }x
    expect { clone.save! validate: false }.to raise_error(regexp)
  end

  context 'with details' do
    before(:each) do
      @cr_format = FactoryGirl.create(:cr_format_with_details)
    end

    it 'should handle its detalis' do
      expect(@cr_format).to respond_to(:details)
      expect(@cr_format.details.count).to eq(3)
    end
  end
end
