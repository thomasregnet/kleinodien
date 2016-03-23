require 'rails_helper'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_models_with_a_reference'
require 'shared_examples_for_models_with_many_references'

RSpec.describe Artist, type: :model do
  before(:each) do
    @artist = FactoryGirl.create(:artist)
  end

  it 'is valid with with valid attributes' do
    expect(@artist).to be_valid
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :artist }
    let(:object) { @artist }
    let(:naming) { 'name' }
  end

  it_behaves_like 'a model with a Reference' do
    let(:factory) { :artist_with_a_reference }
  end

  it_behaves_like 'a model with many References' do
    let(:factory) { :artist_with_many_references }
  end
end
