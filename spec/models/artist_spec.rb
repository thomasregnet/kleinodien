require 'rails_helper'

RSpec.describe Artist, type: :model do
  before(:each) do
    @artist = FactoryGirl.create(:artist)
  end

  it "is valid with with valid attributes" do
    expect(@artist).to be_valid
  end

  it "is not valid without a name" do
    @artist.name = nil
    expect(@artist).not_to be_valid
  end
end
