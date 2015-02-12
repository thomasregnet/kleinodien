require 'rails_helper'

RSpec.describe Serial, type: :model do
  before(:each) do
    @serial = FactoryGirl.create(:serial)
  end

  it "is valid with valid attributes" do
    expect(@serial).to be_valid
  end

  it "is not valid without a title" do
    @serial.title = nil
    expect(@serial).not_to be_valid
  end
end
