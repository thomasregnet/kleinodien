require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe SongHead, type: :model do
  before(:each) do
    @song_head = FactoryBot.create(:song_head)
  end

  it 'is valid with valid attributes' do
    expect(@song_head).to be_valid
  end

  it 'is not valid without an artist_credit' do
    @song_head.artist_credit = nil
    expect(@song_head).not_to be_valid
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :song_head }
    let(:object) { @song_head }
    let(:naming) { 'title' }
  end
end
