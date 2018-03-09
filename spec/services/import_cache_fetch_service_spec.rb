require 'rails_helper'

RSpec.describe ImportCacheFetchService do
  include ImportStore

  describe '.call' do
    let(:key)       { :my_key }
    let(:cache_key) { 'cache:my_key' }
    let(:value)     { 'my_value' }

    before { DatabaseCleaner.start }

    it 'returns the data' do
      GetImportStoreService.call.set(cache_key, value)
      expect(described_class.call(key)).to eq(value)
    end

    after { DatabaseCleaner.clean }
  end
end
