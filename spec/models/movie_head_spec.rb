require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe MovieHead, type: :model do
  before(:each) do
    @movie_head = FactoryBot.create(:movie_head)
  end

  it 'is valid with valid attributes' do
    expect(@movie_head).to be_valid
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :movie_head }
    let(:object) { @movie_head }
    let(:naming) { 'title' }
  end
end
