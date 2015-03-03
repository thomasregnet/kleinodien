require 'rails_helper'

RSpec.describe CompilationRelease, type: :model do
  before(:each) do
    @c_release = FactoryGirl.create(:compilation_release)
  end

  it "is valid with valid attributes" do
    expect(@c_release).to be_valid
  end
end
