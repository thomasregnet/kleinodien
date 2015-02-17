require 'rails_helper'

RSpec.describe Station, type: :model do
  before(:each) do
    @station = FactoryGirl.create(:station)
  end

  it "is valid with valid parameters" do
    expect(@station).to be_valid
  end
end
