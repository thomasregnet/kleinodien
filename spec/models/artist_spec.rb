require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe Artist, type: :model do
  context 'usual artist' do
    before(:each) do
      @artist = FactoryGirl.build(:artist)
    end

    it 'is valid with with valid attributes' do
      expect(@artist).to be_valid
    end

    it_behaves_like 'a model with disambiguations' do
      let(:factory) { :artist }
      let(:object) { @artist }
      let(:naming) { 'name' }
    end
  end

  context 'with source' do
    before(:each) do
      @artist = FactoryGirl.build(:artist_brainz)
    end

    it 'has the source set' do
      expect(@artist.source_name).to eq('MusicBrainz')
    end

    it 'delegates #source_name to source.name' do
      expect(@artist.source.name).to eq('MusicBrainz')
    end

    specify '#source_ident looks like an artist uuid' do
      expect(@artist.source_ident).to match(/^looks-like-an-artist-uuid-/)
    end
  end
end
