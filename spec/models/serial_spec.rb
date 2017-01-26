require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'

RSpec.describe Serial, type: :model do
  specify '#descriptions' do
    expect(subject).to respond_to(:descriptions)
  end

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @commentable = FactoryGirl.create(:serial)
    end

    let(:commentable) { @commentable }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @serial = FactoryGirl.create(:serial)
    end

    let(:rateable) { @serial }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryGirl.create(:serial)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  context 'without seasons' do
    before(:each) do
      @serial = FactoryGirl.build(:serial)
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
