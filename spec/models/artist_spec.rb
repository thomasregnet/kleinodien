require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe Artist, type: :model do
  before(:each) do
    @artist = FactoryGirl.create(:artist)
  end
  
  it "is valid with with valid attributes" do
    expect(@artist).to be_valid
  end

  it_behaves_like "a model with disambiguations" do
    let(:factory) { :artist }
    let(:object) { @artist }
    let(:naming) { 'name' }
  end
end
