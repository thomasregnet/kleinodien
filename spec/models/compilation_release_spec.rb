require 'rails_helper'

RSpec.describe CompilationRelease, type: :model do
  before(:each) do
    @c_release = FactoryGirl.create(:compilation_release)
  end

  it "is valid with valid attributes" do
    expect(@c_release).to be_valid
  end

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
end
