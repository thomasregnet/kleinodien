require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe Serial, type: :model do
  before(:each) do
    @serial = FactoryGirl.create(:serial)
  end

  it "is valid with valid attributes" do
    expect(@serial).to be_valid
  end

  it_behaves_like "a model with disambiguations" do
    let(:factory) { :artist }
    let(:naming) { 'name' }
  end  
end
