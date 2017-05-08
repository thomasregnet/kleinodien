require 'rails_helper'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_commentable'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_identifyable'
require 'shared_examples_for_incomplete_dates'
require 'shared_examples_for_tagable_models'
require 'shared_examples_for_models_with_brainz_constructors'

RSpec.describe Artist, type: :model do
  # TODO: spec Artist has_many: identifiers
  specify '#descriptions' do
    expect(subject).to respond_to(:descriptions)
  end

  specify '#sort_name' do
    expect(subject).to respond_to :sort_name
  end

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @artist = FactoryGirl.create(:artist)
    end

    let(:commentable) { @artist }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'an identifyable model' do
    before(:each) do
      @artist = FactoryGirl.build(:artist)
    end

    let(:identifyable) { @artist }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @artist = FactoryGirl.create(:artist)
    end

    let(:rateable) { @artist }

    after(:all) { DatabaseCleaner.clean }
  end

  context 'with a begin date' do
    it_behaves_like 'a model with an IncompleteDate' do
      let(:candidate)     { FactoryGirl.build(:artist) }
      let(:date_naming) { 'begin_date' }
    end
  end

  context 'with an end date' do
    it_behaves_like 'a model with an IncompleteDate' do
      let(:candidate)     { FactoryGirl.build(:artist) }
      let(:date_naming) { 'end_date' }
    end
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryGirl.create(:artist)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a model with BrainzConstructors' do
    let(:klass) { Artist }
  end

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
end
