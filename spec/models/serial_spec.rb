require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe Serial, type: :model do
  context 'without seasons' do
    before(:each) do
      @serial = FactoryGirl.create(:serial)
    end

    it 'is valid with valid attributes' do
      expect(@serial).to be_valid
    end

    it_behaves_like 'a model with disambiguations' do
      let(:factory) { :serial }
      let(:object) { @serial }
      let(:naming) { 'title' }
    end
  end

  context 'with seasons and episodes' do
    before(:each) do
      @season = FactoryGirl.create(:season_with_tv_episode_heads)
      @serial = @season.serial
    end

    it 'has seasons' do
      expect(@serial.seasons.count).to eq(1)
    end

    it 'has episodes' do
      expect(@serial.episodes.count).to eq(5)
    end
  end
end
