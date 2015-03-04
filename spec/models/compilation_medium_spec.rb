require 'rails_helper'

RSpec.describe CompilationMedium, type: :model do
  before(:each) do
    @medium = FactoryGirl.create(:compilation_medium)
  end

  it "is valid with valid attributes" do
    expect(@medium).to be_valid
  end
end
