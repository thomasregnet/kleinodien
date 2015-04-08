require 'rails_helper'

RSpec.describe TrFormatKind, type: :model do
  before(:each) do
    @trfk = FactoryGirl.create(:tr_format_kind)
  end

  it "is valid with valid attributes" do
    expect(@trfk).to be_valid
  end

  it "is not valid without a name" do
    @trfk.name = ''
    expect(@trfk).not_to be_valid
    
    @trfk.name = nil
    expect(@trfk).not_to be_valid
  end

  it "must have a unique name" do
    clone = TrFormatKind.new(name: @trfk.name)
    expect(clone).not_to be_valid

    clone = TrFormatKind.new(name: @trfk.name.upcase)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error
  end
end
