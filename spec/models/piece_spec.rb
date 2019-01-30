# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_code_findable'
require 'shared_examples_for_models_with_credits'
require 'shared_examples_for_models_with_companies'
require 'shared_examples_for_models_with_countries'
require 'shared_examples_for_incomplete_dates'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'

RSpec.describe Piece, type: :model do
  specify '#descriptions' do
    expect(subject).to respond_to(:descriptions)
  end

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @commentable = FactoryBot.create(:piece)
    end

    let(:commentable) { @commentable }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a code findable entity' do
    before { DatabaseCleaner.start }
    let(:factory) { :piece }
    after { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @piece = FactoryBot.create(:piece)
    end

    let(:rateable) { @piece }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryBot.create(:piece)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  context 'without tracks' do
    before(:each) do
      @piece = FactoryBot.build(:piece_with_head)
    end

    it 'is valid with valid attributes' do
      expect(@piece).to be_valid
    end
  end

  context 'with tracks' do
    before(:each) do
      @piece = FactoryBot.create(:piece_with_tracks)
    end

    it 'has some tracks' do
      expect(@piece.tracks.count).to be > 0
    end
  end

  it_behaves_like 'a model with companies' do
    let(:candidate) { FactoryBot.create(:piece_with_companies) }
  end

  it_behaves_like 'a model with countries' do
    let(:candidate) { FactoryBot.create(:piece_with_countries) }
  end

  it_behaves_like 'a model with credits' do
    let(:candidate) { FactoryBot.create(:piece_with_credits) }
  end

  it_behaves_like 'a model with an IncompleteDate' do
    let(:candidate) { FactoryBot.create(:piece) }
    let(:date_naming) { 'date' }
  end
end
