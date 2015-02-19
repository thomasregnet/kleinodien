require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe PieceHead, type: :model do
  before(:each) do
    @ph = FactoryGirl.create(:piece_head)
  end

  it "is valid with valid attributes" do
    expect(@ph).to be_valid
  end

  it "is not valid without a type" do
    @ph.type = nil
    expect(@ph).not_to be_valid
  end
  
  it_behaves_like "a model with disambiguations" do
    let(:factory) { :piece_head }
    let(:object) { @ph }
    let(:naming) { 'title' }
  end
end
