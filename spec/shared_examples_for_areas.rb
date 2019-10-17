# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.shared_examples 'an area' do
  subject { described_class.new(name: 'test area', sort_name: 'sort area') }

  it { should have_many(:iso3166_part1_countries) }
  it { should have_many(:iso3166_part2_countries) }
  it { should have_many(:iso3166_part3_countries) }

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
end
# rubocop:enable Metrics/BlockLength
