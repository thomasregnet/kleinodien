require 'rails_helper'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_identifyable'

RSpec.describe AlbumHead, type: :model do
  before(:each) do
    @a_head = FactoryGirl.create(:album_head)
  end

  it 'is valid with valid attributes' do
    expect(@a_head).to be_valid
  end

  it 'is not valid without an artist_credit' do
    @a_head.artist_credit = nil
    expect(@a_head).not_to be_valid
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :album_head }
    let(:object) { @a_head }
    let(:naming) { 'title' }
  end

  it_behaves_like 'an identifyable model' do
    before(:each) do
      @album_head = FactoryGirl.create(:album_head_with_identifiers)
    end

    let(:identifyable) { @album_head }
  end
end
