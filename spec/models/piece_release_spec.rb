require 'rails_helper'

RSpec.describe PieceRelease, type: :model do
  before(:each) do
    @piece_release = FactoryGirl.create(:piece_release)
  end

  it "is valid with valid attributes" do
    expect(@piece_release).to be_valid
  end
end
