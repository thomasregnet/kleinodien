require 'rails_helper'

RSpec.describe Track, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @track = FactoryGirl.create(:track)
  end

  it "is valid with valid attributes" do
    expect(@track).to be_valid
  end

  it "is not valid without a format" do
    @track.format = nil
    expect(@track).not_to be_valid
  end

  it "is not valid without a release" do
    @track.release = nil
    expect(@track).not_to be_valid
  end
end
