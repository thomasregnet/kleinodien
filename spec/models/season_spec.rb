require 'rails_helper'
require 'shared_examples_for_commentable'

RSpec.describe Season, type: :model do
  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @commentable = FactoryGirl.create(:season)
    end

    let(:commentable) { @commentable }

    after(:all) { DatabaseCleaner.clean }
  end

  context 'without episodes' do
    before(:each) do
      @season = FactoryGirl.build(:season)
    end

    it 'is valid with valid attributes' do
      expect(@season).to be_valid
    end

    it 'is not valid without a position' do
      @season.position = nil
      expect(@season).not_to be_valid
    end

    it 'is not valid without a serial' do
      @season.serial = nil
      expect(@season).not_to be_valid
    end
  end

  context 'with episodes of a tv-serial' do
    before(:each) do
      @season = FactoryGirl.create(
        :season_with_tv_episode_heads,
        episodes_count: 7
      )
    end

    it 'has the expected count of episodes' do
      expect(@season.episodes.count).to eq(7)
    end
  end
end
