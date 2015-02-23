require 'rails_helper'

RSpec.describe Movie, type: :model do
  before(:each) do
    @movie = FactoryGirl.create(:movie)
  end

  it "is valid with valid attributes" do
    expect(@movie).to be_valid
  end
end
