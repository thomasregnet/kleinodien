# froze_string_literal: true

RSpec.shared_examples 'a cache' do
  subject(:cache) { described_class.new }

  it { is_expected.to respond_to(:fetch).with(1).argument }
  it { is_expected.to respond_to(:store).with(2).arguments }
  it { is_expected.to respond_to(:store).with(3).arguments }

  let(:key) { 'cache_test_key' }
  let(:value) { 'cache_test_value' }

  context 'when nothing is cached' do
    describe '#fetch' do
      it 'returns nil' do
        expect(cache.fetch(key)).to be_nil
      end
    end
  end

  describe 'with something cached' do
    before { cache.store(key, value) }

    describe '#fetch' do
      it 'returns the cached value' do
        expect(cache.fetch(key)).to eq(value)
      end
    end
  end
end
