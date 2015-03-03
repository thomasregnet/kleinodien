require 'rails_helper'

RSpec.describe CompilationIdentifier, type: :model do
  before(:each) do
    @ci = FactoryGirl.create(:compilation_identifier)
  end

  it "is valid with valid attributes" do
    expect(@ci).to be_valid
  end

  it "is not valid without a release"
  it "is not valid without a type"
end
