require 'rails_helper'

RSpec.describe Fetcher::Settings do
  it { is_expected.to respond_to(:fetcher_name) }
  it { is_expected.to respond_to(:name) }

  describe '.fetcher_name' do
    before do
      described_class.name = 'test'
    end

    it 'returns the name' do
      expect(described_class.name).to eq('test')
    end
  end

  describe '#fetcher_name' do
    let(:settings) do
      described_class.name('test')
      described_class.new
    end

    it 'returns the name' do
      expect(described_class.name).to eq('test')
    end
  end
end
