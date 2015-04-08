require 'rails_helper'

RSpec.describe TrfAttribute, type: :model do
  before(:each) do
    @attr = FactoryGirl.create(:trf_attribute)
  end

  it "is valid with valid attributes" do
    expect(@attr).to be_valid
  end

  it "is not valid without a track"
  it "is not valid without a kind"
  it "is not valid without a no"
end
