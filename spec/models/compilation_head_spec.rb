require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe CompilationHead, type: :model do
  before(:each) do
    @c_head = FactoryGirl.create(:compilation_head)
  end

  it "is valid with valid attributes" do
    expect(@c_head).to be_valid
  end

  it_behaves_like "a model with disambiguations" do
    let(:factory) { :compilation_head }
    let(:object) { @c_head }
    let(:naming) { 'title' }
  end
end
