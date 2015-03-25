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

  it "must have a unique combination of release and no"
end
