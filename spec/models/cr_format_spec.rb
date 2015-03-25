require 'rails_helper'

RSpec.describe CrFormat, type: :model do
  before(:each) do
    @cr_format = FactoryGirl.create(:cr_format)
  end

  it "is valid with valid attributes" do
    expect(@cr_format).to be_valid
  end

  it "is not valid without a release"
  it "is not valid without a format_kind"
  it "is not valid without a quantity"
  it "is not valid without a no"

  it "must have a unique combination of release and no"
end
