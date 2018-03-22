require 'rails_helper'
require 'redis_helper'
require 'shared_examples_for_services'

RSpec.describe ClearImportRequestsService do
  it_behaves_like 'a service'

  before do
    DatabaseCleaner.start
    RedisHelper.import_store.lpush('test:requests', 1)
    RedisHelper.import_store.lpush('test:uris', 1)
  end

  it 'clears the requests' do
    described_class.call(importer_name: 'test')
    expect(RedisHelper.import_store.llen('test:requests')).to eq(0)
  end

  it 'clears the uris' do
    described_class.call(importer_name: 'test')
    expect(RedisHelper.import_store.llen('test:uris')).to eq(0)
  end
  after do
    DatabaseCleaner.clean
  end
end
