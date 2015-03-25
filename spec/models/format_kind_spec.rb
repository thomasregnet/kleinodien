require 'rails_helper'

RSpec.describe FormatKind, type: :model do
  before(:each) do
    @fki = FactoryGirl.create(:format_kind)
  end

  it "is valid with valid attributes" do
    expect(@fki).to be_valid
  end

  it "is not valid without a name" do
    @fki.name = nil
    expect(@fki).not_to be_valid
    expect { @fki.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)
    
    @fki.name = ''
    expect(@fki).not_to be_valid
  end
    
  it "is not valid without a type" do
    @fki.type = nil
    expect(@fki).not_to be_valid
    expect { @fki.save! validate: false }
      .to raise_error(ActiveRecord::StatementInvalid)

    @fki.type = ''
    expect(@fki).not_to be_valid
  end

  it "must have a unique name" do
    clone = FormatKind.new(name: @fki.name, type: @fki.type)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error
    
    clone = FormatKind.new(name: @fki.name.upcase, type: @fki.type)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error
  end
end
