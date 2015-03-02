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
  end
end
