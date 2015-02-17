require 'rails_helper'

RSpec.describe Piece, type: :model do
  before(:each) do
    @piece = FactoryGirl.create(:piece)
  end

  it "is valid with valid attributes" do
    expect(@piece).to be_valid
  end
end
