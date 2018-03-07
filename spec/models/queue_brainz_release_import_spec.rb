require 'rails_helper'

RSpec.describe QueueBrainzReleaseImport, type: :model do
  it { is_expected.to respond_to(:code) }

  describe '.perform' do
    before(:each) { DatabaseCleaner.start }

    # let(:redis) { Redis.new(host: 'redis', timeout: 3) }
    let(:redis) { ImportConnection.redis }

    it 'queues to redis' do
      described_class.perform(code: 'abc')
      expect(redis.lindex('brainz:wait', 0)).to eq('abc')
    end

    after(:each) { DatabaseCleaner.clean }
  end
end
