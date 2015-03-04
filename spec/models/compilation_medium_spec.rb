require 'rails_helper'

RSpec.describe CompilationMedium, type: :model do
  before(:each) do
    @medium = FactoryGirl.create(:compilation_medium)
  end

  it "is valid with valid attributes" do
    expect(@medium).to be_valid
  end

  it "is not valid without a release" do
    @medium.release = nil
    expect(@medium).not_to be_valid
  end
  
  it "is not valid without a no" do
    @medium.no = nil
    expect(@medium).not_to be_valid
  end

  it "must have a unique combination of release and no" do
    clone = FactoryGirl.build(:compilation_medium) do |c|
      c.release = @medium.release
      c.no      = @medium.no
    end
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error(
                                                ActiveRecord::RecordNotUnique)
  end
end
