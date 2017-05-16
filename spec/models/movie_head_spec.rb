require 'rails_helper'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_identifyable'

RSpec.describe MovieHead, type: :model do
  before(:each) do
    @movie_head = FactoryGirl.create(:movie_head)
  end

  it 'is valid with valid attributes' do
    expect(@movie_head).to be_valid
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :movie_head }
    let(:object) { @movie_head }
    let(:naming) { 'title' }
  end

  it_behaves_like 'an identifyable model' do
    let(:identifyable) { FactoryGirl.create(:movie_head_with_identifiers) }
  end
end
