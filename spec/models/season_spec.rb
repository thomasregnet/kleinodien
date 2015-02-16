require 'rails_helper'

RSpec.describe Season, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @season = FactoryGirl.create(:season)
  end

  it "is valid with valid attributes" do
    expect(@season).to be_valid
  end

  it "is not valid without a no" do
    @season.no = nil
    expect(@season).not_to be_valid
  end

  it "is not valid without a serial" do
    @season.serial = nil
    expect(@season).not_to be_valid
  end
end
