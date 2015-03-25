require 'rails_helper'

RSpec.describe CrFormat, type: :model do
  before(:each) do
    @cr_format = FactoryGirl.create(:cr_format)
  end

  it "is valid with valid attributes" do
    expect(@cr_format).to be_valid
  end
end
