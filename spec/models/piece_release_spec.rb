require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_models_with_credits'
require 'shared_examples_for_models_with_companies'
require 'shared_examples_for_models_with_countries'
require 'shared_examples_for_models_with_labels'
require 'shared_examples_for_incomplete_dates'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_sources'
require 'shared_examples_for_tagable_models'

RSpec.describe PieceRelease, type: :model do
  specify '#descriptions' do
    expect(subject).to respond_to(:descriptions)
  end

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @commentable = FactoryGirl.create(:piece_release)
    end

    let(:commentable) { @commentable }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @piece_release = FactoryGirl.create(:piece_release)
    end

    let(:rateable) { @piece_release }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryGirl.create(:piece_release)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  context 'without tracks' do
    before(:each) do
      @piece_release = FactoryGirl.build(:piece_release)
    end

    it 'is valid with valid attributes' do
      expect(@piece_release).to be_valid
    end

    it 'delegates title to its head' do
      expect(@piece_release.title).to eq(@piece_release.head.title)
    end
  end

  context 'with tracks' do
    before(:each) do
      @piece_release = FactoryGirl.create(:piece_release_with_tracks)
    end

    it 'has some tracks' do
      expect(@piece_release.tracks.count).to be > 0
    end
  end

  it_behaves_like 'a model with companies' do
    let(:candidate) { FactoryGirl.create(:piece_release_with_companies) }
  end

  it_behaves_like 'a model with countries' do
    let(:candidate) { FactoryGirl.create(:piece_release_with_countries) }
  end

  it_behaves_like 'a model with credits' do
    let(:candidate) { FactoryGirl.create(:piece_release_with_credits) }
  end

  it_behaves_like 'a model with labels' do
    let(:candidate) { FactoryGirl.create(:piece_release_with_labels) }
  end

  it_behaves_like 'a model with an IncompleteDate' do
    let(:candidate) { FactoryGirl.create(:piece_release) }
    let(:date_naming) { 'date' }
  end

  it_behaves_like 'an object with a source' do
    let(:factory) { :piece_release }
  end
end
