require 'rails_helper'

RSpec.describe SectionFormat, type: :model do
  before(:each) do
    @format = FactoryGirl.create(:section_format)
  end

  it "is valid with valid attributes" do
    expect(@format).to be_valid
  end
end
