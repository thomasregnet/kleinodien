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
    expect { @section.save! validate: false }.to raise_error(
                                          ActiveRecord::StatementInvalid)
  end
  
  it "is not valid without a format" do
    @section.format = nil
    expect(@section).not_to be_valid
    expect { @section.save! validate: false }.to raise_error(
                                          ActiveRecord::StatementInvalid)
  end

  it "is valid with a side named either A or B" do
    @section.side = 'A'
    expect(@section).to be_valid
    @section.side = 'B'
    expect(@section).to be_valid
  end
  
  it "is not valid with a bad side name" do
    @section.side = 'C'
    expect(@section).not_to be_valid
    @section.side = 'a'
    expect(@section).not_to be_valid
    @section.side = 'AB'
    expect(@section).not_to be_valid    
  end

  it "must have a unique combination of medium and no" do
    clone = FactoryGirl.build(:compilation_section) do |c|
      c.medium = @section.medium
      c.no     = @section.no
    end
    expect(clone).not_to be_valid
  end

  context "with a side" do
    before(:each) do
      @section = FactoryGirl.create(:compilation_section_with_side)
    end
    
    it "is valid with a unique combination of medium side and no" do
      clone = FactoryGirl.build(:compilation_section) do |c|
        c.medium = @section.medium
        c.no     = @section.no
        c.side   = 'B'
      end
      expect(clone).to be_valid
    end
    
    it "is not valid when a medium, side and no are not unique" do
      clone = FactoryGirl.build(:compilation_section) do |c|
        c.medium = @section.medium
        c.no     = @section.no
        c.side   = @section.side
      end
      expect(clone).not_to be_valid
    end
  end
end
