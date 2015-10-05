require 'rails_helper'

RSpec.describe CrCredit, type: :model do
  before(:each) do
    @cr_credit = FactoryGirl.create(:cr_credit)
  end

  it "is valid with valid attributes" do
    expect(@cr_credit).to be_valid
  end
end
