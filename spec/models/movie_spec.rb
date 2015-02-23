require 'rails_helper'
require 'shared_examples_for_pieces'

RSpec.describe Movie, type: :model do
  before(:each) do
    @movie = FactoryGirl.create(:movie)
  end

  it "is valid with valid attributes" do
    expect(@movie).to be_valid
  end

  it_behaves_like "a piece" do
    let(:piece) { @movie }
  end
end
