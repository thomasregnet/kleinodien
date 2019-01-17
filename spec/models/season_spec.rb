# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_code_findable'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'

RSpec.describe Season, type: :model do
  it { is_expected.to have_many(:set_heads) }

  specify '#descriptions' do
    expect(subject).to respond_to(:descriptions)
  end

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @commentable = FactoryBot.create(:season)
    end

    let(:commentable) { @commentable }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a code findable entity' do
    before { DatabaseCleaner.start }
    let(:factory) { :season }
    after { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @season = FactoryBot.create(:season)
    end

    let(:rateable) { @season }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryBot.create(:season)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  context 'without episodes' do
    before(:each) do
      @season = FactoryBot.build(:season)
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
      @season = FactoryBot.create(
        :season_with_tv_episode_heads,
        episodes_count: 7
      )
    end

    it 'has the expected count of episodes' do
      expect(@season.episodes.count).to eq(7)
    end
  end
end
