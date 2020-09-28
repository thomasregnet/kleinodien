# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_code_findable'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'

RSpec.describe Season, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryBot.build(:season)).to be_valid
  end

  it_behaves_like 'a code findable entity' do
    before { DatabaseCleaner.start }

    let(:factory) { :season }
    after { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    let(:rateable) { FactoryBot.build(:season) }
  end

  it_behaves_like 'a tagable model' do
    let(:tagable) { FactoryBot.build(:season) }
  end

  context 'without episodes' do
    it 'is not valid without a position' do
      season = FactoryBot.build(:season)
      season.position = nil
      expect(season).not_to be_valid
    end

    it 'is not valid without a serial' do
      season = FactoryBot.build(:season)
      season.serial = nil
      expect(season).not_to be_valid
    end
  end

  context 'with episodes of a tv-serial' do
    let(:season) do
      FactoryBot.create(
        :season_with_tv_episode_heads,
        episodes_count: 2
      )
    end

    it 'has the expected count of episodes' do
      expect(season.episodes.count).to eq(2)
    end
  end
end
