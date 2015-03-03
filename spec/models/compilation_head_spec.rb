require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe CompilationHead, type: :model do
  before(:each) do
    @c_head = FactoryGirl.create(:compilation_head)
  end

  it "is valid with valid attributes" do
    expect(@c_head).to be_valid
  end
end
