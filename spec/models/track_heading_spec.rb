require 'rails_helper'

RSpec.describe TrackHeading, type: :model do
  before(:each) do
    @heading = FactoryGirl.create(:track_heading)
  end

  it "is valid with valid attributes" do
    expect(@heading).to be_valid
  end

  it "is not valid without a heading" do
    @heading.heading = ''
    expect(@heading).not_to be_valid

    @heading.heading = nil
    expect(@heading).not_to be_valid
  end
end
