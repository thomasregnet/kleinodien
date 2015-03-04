require 'rails_helper'

RSpec.describe Track, type: :model do
  before(:each) do
    @track = FactoryGirl.create(:track)
  end

  it "is valid with valid attributes" do
    expect(@track).to be_valid
  end

  it "is not valid without a format" do
    @track.format = nil
    expect(@track).not_to be_valid
  end

  it "is not valid without a release" do
    @track.release = nil
    expect(@track).not_to be_valid
  end

  context "with a section" do
    before(:each) do
      @track = FactoryGirl.create(:track_with_section)
    end
    
    it "has access to its section" do
      expect(@track.section).to be_instance_of(CompilationSection)
    end
  end
end
