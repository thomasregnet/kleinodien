require 'rails_helper'

RSpec.describe ArtistIdentifier, type: :model do
  context 'simple' do
    before(:each) do
      @identifier = FactoryGirl.build(:artist_identifier)
    end

    it 'is valid with valid parameters' do
      expect(@identifier).to be_valid
    end

    it 'is not valid without a source' do
      @identifier.source = nil
      expect(@identifier).not_to be_valid
    end

    it 'is not valid without a value' do
      @identifier.value = nil
      expect(@identifier).not_to be_valid
    end

    it 'is not valid with a blank value' do
      @identifier.value = ''
      expect(@identifier).not_to be_valid
    end
  end

  context 'with an artist' do
    before(:all) do
      DatabaseCleaner.start
      @identifier = FactoryGirl.create(:artist)
    end
    
    it 'has one artist' do
      expect(@identifier).to be_valid
    end

    specify '#identified' do

      expect(@identifier).to be_instance_of Artist
    end

    after(:each) { DatabaseCleaner.clean }
  end

  context 'with an alternative identified' do
    before(:all) do
      DatabaseCleaner.start
      @identifier = FactoryGirl.create(:artist_identifier)
    end

    specify '#alt_identified' do
      @identifier.alt_identified << FactoryGirl.create(:artist)
      expect(@identifier.alt_identified.length).to eq 1
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
