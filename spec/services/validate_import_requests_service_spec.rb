require 'rails_helper'
require 'redis_helper'
require 'shared_examples_for_services'

RSpec.describe ValidateImportRequestsService do
  it_behaves_like 'a service'

  before { DatabaseCleaner.start }
  let(:args) { { importer_name: 'test' } }

  context 'without requests and uris' do
    it 'returns true' do
      expect(described_class.call(args)).to be true
    end
  end

  context 'with requests and without uris' do
    it 'returns true' do
      RedisHelper.import_store.lpush('test:requests', 'test')
      expect(described_class.call(args)).to be true
    end
  end

  context 'with requests and with uris' do
    it 'returns true' do
      RedisHelper.import_store.lpush('test:requests', 'test')
      RedisHelper.import_store.lpush('test:uris', 'test')

      expect(described_class.call(args)).to be true
    end
  end

  context 'without requests and with uris' do
    it 'returns false' do
      RedisHelper.import_store.lpush('test:uris', 'test')
      expect(described_class.call(args)).to be false
    end
  end

  after { DatabaseCleaner.clean }
end
