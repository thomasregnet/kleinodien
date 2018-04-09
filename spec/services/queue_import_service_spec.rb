require 'rails_helper'
require 'redis_helper'
require 'shared_examples_for_services'

RSpec.describe QueueImportService do
  it_behaves_like 'a service'

  before do
    DatabaseCleaner.start
  end

  it 'queues an ImportRequest' do
    described_class.call(
      importer_name: 'test',
      request: 'just a string'
    )
    expect(RedisHelper.import_store.llen('test:requests:queue')).to eq(1)
  end

  after do
    DatabaseCleaner.clean
  end
end
