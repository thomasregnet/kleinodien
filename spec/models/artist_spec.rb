# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_code_findable'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_incomplete_dates'
require 'shared_examples_for_tagable_models'

RSpec.describe Artist, type: :model do
  it { is_expected.to belong_to(:import_order).without_validating_presence }
  it { is_expected.to respond_to(:sort_name) }

  it 'is valid with valid attributes' do
    expect(FactoryBot.build(:artist)).to be_valid
  end

  it_behaves_like 'a code findable entity' do
    let(:factory) { :artist }
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

  it_behaves_like 'a rateable model' do
    let(:rateable) { FactoryBot.build(:artist) }
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
    let(:tagable) { FactoryBot.build(:artist) }
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :artist }
    let(:object) { FactoryBot.build(:artist) }
    let(:naming) { 'name' }
  end
end
