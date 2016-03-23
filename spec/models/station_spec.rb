require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe Station, type: :model do
  before(:each) do
    @station = FactoryGirl.create(:station)
  end

  it 'is valid with valid parameters' do
    expect(@station).to be_valid
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :station }
    let(:object) { @station }
    let(:naming) { 'name' }
  end
end
