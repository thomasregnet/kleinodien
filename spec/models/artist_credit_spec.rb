require 'rails_helper'

RSpec.describe ArtistCredit, type: :model do
  before(:each) do
    @artist_credit = FactoryGirl.create(:artist_credit)
  end

  it "is valid with valid attributes" do
    expect(@artist_credit).to be_valid
  end

  it "is not valid without a name" do
    @artist_credit.name = nil
    expect(@artist_credit).not_to be_valid
  end

  it "must have a unique name" do
    clone = ArtistCredit.new(name: @artist_credit.name)
    expect(clone).not_to be_valid
  end 
end
