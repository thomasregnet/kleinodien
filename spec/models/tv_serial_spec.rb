require 'rails_helper'

RSpec.describe TvSerial, type: :model do
  before(:each) do
    @tv_serial = FactoryGirl.create(:tv_serial)
  end

  it "is valid with valid attributes" do
    expect(@tv_serial).to be_valid
  end
end
