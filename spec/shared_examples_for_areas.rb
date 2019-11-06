# frozen_string_literal: true

require 'shared_examples_for_incomplete_dates'

# rubocop:disable Metrics/BlockLength
RSpec.shared_examples 'an area' do
  subject { described_class.new(name: 'test area', sort_name: 'sort area') }

  it { should respond_to(:brainz_code) }
  it { should respond_to(:gone) }

  it { should belong_to(:import_order).required(false) }

  it { should have_many(:iso3166_part1_countries) }
  it { should have_many(:iso3166_part2_countries) }
  it { should have_many(:iso3166_part3_countries) }
  it { should have_many(:release_events) }
  it { should have_many(:releases) }

  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_uniqueness_of(:sort_name).case_insensitive }

  context 'with valid parameters' do
    let(:area) { described_class.new(name: 'test area') }

    it 'is valid' do
      expect(area).to be_valid
    end
  end

  describe '#name' do
    context 'when nil' do
      let(:area) { described_class.new }

      it 'is not valid' do
        expect(area).not_to be_valid
      end
    end

    context 'when blank' do
      let(:area) { described_class.new(name: '') }

      it 'is not valid' do
        expect(area).not_to be_valid
      end
    end
  end

  describe '#begin_date' do
    it_behaves_like 'a model with an IncompleteDate' do
      let(:candidate) { described_class.new(FactoryBot.attributes_for(:area)) }
      let(:date_naming) { 'begin_date' }
    end
  end

  describe '#end_date' do
    it_behaves_like 'a model with an IncompleteDate' do
      let(:candidate) { described_class.new(FactoryBot.attributes_for(:area)) }
      let(:date_naming) { 'end_date' }
    end
  end

  describe '#sort_name' do
    context 'when blank' do
      let(:area) { described_class.new(name: 'test area', sort_name: '') }

      it 'is not valid' do
        expect(area).not_to be_valid
      end
    end

    context 'when nil and the name has a value' do
      let(:area) { described_class.new(name: 'test area') }

      it 'sets the sort_name on validation if none is given' do
        area.valid?
        expect(area.sort_name).to eq('test area')
      end
    end
  end

  describe '#iso3166_part1_codes' do
    context 'without ISO 3166-1 codes' do
      let(:area) { FactoryBot.build(:area) }

      it 'returns nil' do
        expect(area.iso3166_part1_codes).to be_empty
      end
    end

    context 'with an ISO 3166-1 code' do
      let(:area) { FactoryBot.create(:area) }
      let(:iso_country) { FactoryBot.create(:iso3166_part1_country) }

      before { area.iso3166_part1_countries << iso_country }

      it 'returns that code' do
        expect(area.iso3166_part1_codes.first).to eq(iso_country.code)
      end
    end

    context 'with many ISO 3166-1 codes' do
      let(:area) { FactoryBot.create(:area) }

      before do
        2.times do
          area.iso3166_part1_countries << FactoryBot.create(
            :iso3166_part1_country
          )
        end
      end

      it 'returns that codes' do
        expect(area.iso3166_part1_codes.length).to eq(2)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
