require 'rails_helper'

RSpec.describe CompilationSection, type: :model do
  before(:each) do
    @section = FactoryGirl.create(:compilation_section)
  end

  it "is valid with valid attributes" do
    expect(@section).to be_valid
  end

  it "is not valid without a medium" do
    @section.medium = nil
    expect(@section).not_to be_valid
  end
  
  it "is not valid without a format" do
    @section.format = nil
    expect(@section).not_to be_valid
  end
end
