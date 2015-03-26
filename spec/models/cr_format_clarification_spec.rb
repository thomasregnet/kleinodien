require 'rails_helper'

RSpec.describe CrFormatClarification, type: :model do
  before(:each) do
    @clarification = FactoryGirl.create(:cr_format_clarification)
  end

  it "is valid with valid attributes" do
    expect(@clarification).to be_valid
  end
end
