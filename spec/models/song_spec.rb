require 'rails_helper'
require 'shared_examples_for_pieces'

RSpec.describe Song, type: :model do
  before(:each) do
    @song = FactoryGirl.create(:song)
  end

  it "is valid with valid attributes" do
    expect(@song).to be_valid
  end

  it_behaves_like "a piece" do
    #let(:factory) { :song }
    let(:piece) { @song }
  end
end
