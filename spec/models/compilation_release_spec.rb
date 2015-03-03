require 'rails_helper'

RSpec.describe CompilationRelease, type: :model do
  before(:each) do
    @c_release = FactoryGirl.create(:compilation_release)
  end

  it "is valid with valid attributes" do
    expect(@c_release).to be_valid
  end

  it "is not unique without a head"
  it "is not unique without a type"
  
  it "has a unique head" do
    other_release = CompilationRelease.new(head: @c_release.head)
    expect(other_release).not_to be_valid
    # TODO: save! without validation
  end

  it "is valid with a duplicate head and a version" do
    other_release = CompilationRelease.new(head: @c_release.head)
    other_release.version = 'other one'
    expect(other_release).to be_valid
  end

  it "is not valid with a duplicate head and duplicate version" do
    @c_release.version = 'version 1'
    @c_release.save!
    other_release = CompilationRelease.new(
      head: @c_release.head, version: @c_release.version)
    expect(other_release).not_to be_valid
  end

    it "is not valid with a duplicate head and duplicate upcase version" do
    @c_release.version = 'version 1'
    @c_release.save!
    other_release = CompilationRelease.new(
      head: @c_release.head, version: @c_release.version.upcase)
    expect(other_release).not_to be_valid
  end
end
