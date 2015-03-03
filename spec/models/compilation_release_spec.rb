require 'rails_helper'

RSpec.describe CompilationRelease, type: :model do
  before(:each) do
    @c_release = FactoryGirl.create(:compilation_release)
  end

  it "is valid with valid attributes" do
    expect(@c_release).to be_valid
  end

  it "is not unique without a head" do
    @c_release.head = nil
    expect(@c_release).not_to be_valid
  end
  
  it "is not unique without a type" do
    @c_release.type = nil
    expect(@c_release).not_to be_valid
  end
  
  it "has a unique head" do
    clone = CompilationRelease.new(
      head: @c_release.head, type: @c_release.type)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error(
                                                ActiveRecord::RecordNotUnique)
  end

  it "is valid with a duplicate head and a version" do
    clone = CompilationRelease.new(
      head: @c_release.head, type: @c_release.type)
    clone.version = 'other one'
    expect(clone).to be_valid
  end

  it "is not valid with a duplicate head and duplicate version" do
    @c_release.version = 'version 1'
    @c_release.save!
    clone = FactoryGirl.build(:compilation_release,
                              head: @c_release.head,
                              version: @c_release.version)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error(
                                                ActiveRecord::RecordNotUnique)
  end

    it "is not valid with a duplicate head and duplicate upcase version" do
    @c_release.version = 'version 1'
    @c_release.save!
    clone = FactoryGirl.build(:compilation_release,
                              head: @c_release.head,
                              version: @c_release.version.upcase)
    expect(clone).not_to be_valid
    expect { clone.save! validate: false }.to raise_error(
                                                ActiveRecord::RecordNotUnique)
  end
end
