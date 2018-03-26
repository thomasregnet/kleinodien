require 'rails_helper'
require 'shared_examples_for_services'
require 'redis_helper'

RSpec.describe FetchDataService do
  let(:args) { { importer_name: 'test' } }

  it_behaves_like 'a service'

  before do
    DatabaseCleaner.start
  end

  context 'without uris' do
    it 'does nothing' do
      expect(described_class.call(args)).to be false
    end
  end

  context 'with an uri' do
    let(:uri) do
      'http://musicbrainz.org/ws/2/artist/'\
      '1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
    end

    before do
      RedisHelper.import_store.lpush('test:uris', uri)
      described_class.call(args)
    end

    it 'caches the data' do
      expect(RedisHelper.import_store.get("cache:#{uri}")).to match(/<\?xml/)
    end

    it 'removes the uri' do
      expect(RedisHelper.import_store.llen('test:uris')).not_to be_positive
    end
  end

  after do
    DatabaseCleaner.clean
  end
end
