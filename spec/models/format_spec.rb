require 'rails_helper'

RSpec.describe Format, type: :model do
  before(:each) do
    @format = FactoryGirl.create(:format)
  end

  it "is valid with valid attributes" do
    expect(@format).to be_valid
  end

  it "is not valid without a name" do
    @format.name = nil
    expect(@format).not_to be_valid
    expect { @format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
    
    @format.name = ''
    expect(@format).not_to be_valid
  end
    
  it "is not valid without a type" do
    @format.type = nil
    expect(@format).not_to be_valid
    expect { @format.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)

    @format.type = ''
    expect(@format).not_to be_valid
  end

  it "must have a unique name" do
    clone = Format.new(name: @format.name, type: @format.type)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error
    
    clone = Format.new(name: @format.name.upcase, type: @format.type)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error
  end
end
