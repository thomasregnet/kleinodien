require 'rails_helper'

RSpec.describe Song, type: :model do
  before(:each) do
    @song = FactoryGirl.create(:song)
  end

  it "is valid with valid attributes" do
    expect(@song).to be_valid
  end
end
