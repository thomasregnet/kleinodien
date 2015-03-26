require 'rails_helper'

RSpec.describe CrFormat, type: :model do
  before(:each) do
    @cr_format = FactoryGirl.create(:cr_format)
  end

  it "is valid with valid attributes" do
    expect(@cr_format).to be_valid
  end

  it "is not valid without a release" do
    @cr_format.release = nil
    expect(@cr_format).not_to be_valid
    expect { @cr_format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
  end
  
  it "is not valid without a format_kind" do
    @cr_format.format_kind = nil
    expect(@cr_format).not_to be_valid
    expect { @cr_format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
  end
  
  it "is not valid without a quantity" do
    @cr_format.quantity = nil
    expect(@cr_format).not_to be_valid
    expect { @cr_format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
  end
  
  it "is not valid without a no" do
    @cr_format.no = nil
    expect(@cr_format).not_to be_valid
    expect { @cr_format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
  end


  it "must have a unique combination of release and no" do
    clone = CrFormat.new do |c|
      c.release     = @cr_format.release
      c.no          = @cr_format.no
      c.quantity    = @cr_format.quantity
      c.format_kind = @cr_format.format_kind
    end
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error
  end

  context "with clarificatons" do
    before(:each) do
      @cr_format = FactoryGirl.create(:cr_format_with_clarifications)
    end
    
    it "should return the expected count of clarifications" do
      expect(@cr_format).to respond_to(:clarifications)
      expect(@cr_format.clarifications.count).to eq(3)
    end
  end
end
