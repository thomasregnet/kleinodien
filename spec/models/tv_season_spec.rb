require 'rails_helper'

RSpec.describe TvSeason, type: :model do
  before(:each) do
    @tv_season = FactoryGirl.create(:tv_season)
  end

  it "is valid with valid attributes" do
    expect(@tv_season).to be_valid
  end
end
