require 'rails_helper'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_code_findable'
require 'shared_examples_for_commentable'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_incomplete_dates'
require 'shared_examples_for_tagable_models'
require 'shared_examples_for_models_with_brainz_constructors'

RSpec.describe Artist, type: :model do
  it { is_expected.to(belong_to(:data_import)) }

  it_behaves_like 'a code findable entity' do
    before { DatabaseCleaner.start }
    let(:factory) { :artist }
    after { DatabaseCleaner.clean }
  end

  context 'with brainz_code' do
    let(:artist) do
      FactoryBot.build(
        :artist,
        brainz_code: '51648f70-382a-47c2-aeb4-04fd125b928a'
      )
    end

    it 'accepts a string as uuid' do
      expect { artist.save! }.not_to raise_error
    end

    it 'returns the value as string' do
      expect(artist.brainz_code).to be_instance_of(String)
    end
  end

  describe '#brainz_code' do
    subject do
      FactoryBot.create(
        :artist,
        brainz_code: '51648f70-382a-47c2-aeb4-04fd125b928a'
      )
    end

    it { should validate_uniqueness_of(:brainz_code).case_insensitive }
  end

  describe '#discogs_code' do
    subject do
      FactoryBot.create(
        :artist,
        discogs_code: 123
      )
    end

    it { should validate_uniqueness_of(:discogs_code) }
  end

  describe '#wikidata_code' do
    subject do
      FactoryBot.create(
        :artist,
        wikidata_code: '51648f70-382a-47c2-aeb4-04fd125b928a'
      )
    end

    it { should validate_uniqueness_of(:wikidata_code).case_insensitive }
  end

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
      @artist = FactoryBot.create(:artist)
    end

    let(:commentable) { @artist }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @artist = FactoryBot.create(:artist)
    end

    let(:rateable) { @artist }

    after(:all) { DatabaseCleaner.clean }
  end

  context 'with a begin date' do
    it_behaves_like 'a model with an IncompleteDate' do
      let(:candidate)     { FactoryBot.build(:artist) }
      let(:date_naming) { 'begin_date' }
    end
  end

  context 'with an end date' do
    it_behaves_like 'a model with an IncompleteDate' do
      let(:candidate)     { FactoryBot.build(:artist) }
      let(:date_naming) { 'end_date' }
    end
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryBot.create(:artist)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a model with BrainzConstructors' do
    let(:klass) { Artist }
  end

  context 'usual artist' do
    before(:each) do
      @artist = FactoryBot.build(:artist)
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
