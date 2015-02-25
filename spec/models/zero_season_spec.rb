require 'rails_helper'

RSpec.describe ZeroSeason, type: :model do
  before(:each) do
    @zero_season = FactoryGirl.create(:zero_season)
  end

  it "is valid with valid attributes" do
    expect(@zero_season).to be_valid
  end
end
