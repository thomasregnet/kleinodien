require 'rails_helper'

RSpec.describe RegularSeason, type: :model do
  before(:each) do
    @reg_season = FactoryGirl.create(:regular_season)
  end

  it "is valid with valid attributes" do
    expect(@reg_season).to be_valid
  end
end
