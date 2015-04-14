require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe PieceHead, type: :model do
  before(:each) do
    @ph = FactoryGirl.create(:piece_head)
  end

  it "is valid with valid attributes" do
    expect(@ph).to be_valid
  end

  it "is allowed to use same 'name' and 'disambiguation' if type 'differs'" do
    @s_head = FactoryGirl.build(
      :song_head,
      title:          @ph.title,
      disambiguation: @ph.disambiguation
    )
    expect(@s_head).to be_valid
    expect { @s_head.save! }.not_to raise_error

    disambiguation = 'disambiguate this!'
    @s_head.disambiguation = disambiguation
    @ph.disambiguation = disambiguation
    expect(@s_head).to be_valid
    expect(@ph).to be_valid
    expect { @s_head.save! }.not_to raise_error
    expect { @ph.save! }.not_to raise_error
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
