require 'rails_helper'

RSpec.describe CrFormatClarification, type: :model do
  before(:each) do
    @clarification = FactoryGirl.create(:cr_format_clarification)
  end

  it "is valid with valid attributes" do
    expect(@clarification).to be_valid
  end

  it "is not valid without a format" do
    @clarification.format = nil
    expect(@clarification).not_to be_valid
  end
  
  it "is not valid without a format_kind" do
    @clarification.kind = nil
    expect(@clarification).not_to be_valid
  end
  
  it "is not valid without a no" do
    @clarification.no = nil
    expect(@clarification).not_to be_valid
  end

  it "must have a unique a combination of format and no" do
    clone = CrFormatClarification.new do |c|
      c.format = @clarification.format
      c.kind   = @clarification.kind
      c.no     = @clarification.no
    end
    expect(clone).not_to be_valid
    expect{ clone.save! validate: false }
      .to raise_error(ActiveRecord::RecordNotUnique)
  end
end
