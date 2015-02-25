require 'rails_helper'

RSpec.describe ZeroSeason, type: :model do
  before(:each) do
    @zero_season = FactoryGirl.create(:zero_season)
  end

  it { should respond_to(:episodes) }
  
  it "is valid with valid attributes" do
    expect(@zero_season).to be_valid
  end

  it "is not valid with another 'no' than 0" do
    @zero_season.no = 1
    expect(@zero_season).not_to be_valid
  end

  it "is not valid without a 'no'" do
    @zero_season.no = nil
    expect(@zero_season).not_to be_valid
  end
end
