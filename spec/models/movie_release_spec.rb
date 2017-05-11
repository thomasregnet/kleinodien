require 'rails_helper'
require 'shared_examples_for_pieces'
require 'shared_examples_for_identifyable'

RSpec.describe MovieRelease, type: :model do
  before(:each) do
    @movie_release = FactoryGirl.create(:movie_release)
  end

  it 'is valid with valid attributes' do
    expect(@movie_release).to be_valid
  end

  it_behaves_like 'a piece' do
    let(:piece) { @movie_release }
  end

  it_behaves_like 'an identifyable model' do
    before(:each) do
      @movie_release = FactoryGirl.create(:movie_release_with_identifiers)
    end

    let(:identifyable) { @movie_release }
  end
end
