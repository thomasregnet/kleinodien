require 'rails_helper'
require 'fake_fetcher_getter'

RSpec.describe Fetcher::WorkingQueue do
  context 'when nothing is queued' do
    let(:redis) { Redis.new(host: 'redis', timeout: 3) }
    let(:wq_name) { 'test:https://example.com/no/such/data' }

    describe '.perform' do
      it 'returns false' do
        args = { redis: redis, working_queue_name: wq_name }
        expect(described_class.perform(args)).to be false
      end
    end
  end

  context 'with jobs in the queue' do
    before do
      DatabaseCleaner.start
      @redis = Redis.new(host: 'redis', timeout: 3)
      @wq_name = 'test:http://example.com/foo/bar'
      @redis.lpush(@wq_name, 'https://example.com/foo/bar?baz')
    end

    describe '.perform' do
      it 'returns true' do
        args = {
          getter_class:       FakeFetcherGetter,
          redis:              @redis,
          working_queue_name: @wq_name,
        }
        expect(described_class.perform(args)).to be true
      end
    end

    after { DatabaseCleaner.clean }
  end
end
