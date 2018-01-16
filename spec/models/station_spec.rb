require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_tagable_models'

RSpec.describe Station, type: :model do
  specify '#descriptions' do
    expect(subject).to respond_to(:descriptions)
  end

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @commentable = FactoryBot.create(:station)
    end

    let(:commentable) { @commentable }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @station = FactoryBot.create(:station)
    end

    let(:rateable) { @station }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryBot.create(:station)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  before(:each) do
    @station = FactoryBot.build(:station)
  end

  it 'is valid with valid parameters' do
    expect(@station).to be_valid
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :station }
    let(:object) { @station }
    let(:naming) { 'name' }
  end
end
