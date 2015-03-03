require 'rails_helper'

RSpec.describe CompilationIdentifier, type: :model do
  before(:each) do
    @ci = FactoryGirl.create(:compilation_identifier)
  end

  it "is valid with valid attributes" do
    expect(@ci).to be_valid
  end

  it "is not valid without a release" do
    @ci.release = nil
    expect(@ci).not_to be_valid
  end
  
  it "is not valid without a type"  do
    @ci.type = nil
    expect(@ci).not_to be_valid
  end

  it "is not valid without a code" do
    @ci.code = nil
    expect(@ci).not_to be_valid
  end

  it "is not valid with a blank code" do
    @ci.code = ''
    expect(@ci).not_to be_valid
  end

  it "must have a unique code" do
    clone = FactoryGirl.build(:compilation_identifier) do |c|
      c.release = @ci.release
      c.type    = @ci.type
      c.code    = @ci.code
    end
    expect(clone).not_to be_valid
  end
end
