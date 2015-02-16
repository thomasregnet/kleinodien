require 'rails_helper'

RSpec.describe Season, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @season = FactoryGirl.create(:season)
  end

  it "is valid with valid attributes" do
    expect(@season).to be_valid
  end
end
