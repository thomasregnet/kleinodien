require 'rails_helper'

RSpec.describe Fetcher::Get do
  describe '.perform' do
    it 'returns the requested data' do
      expect(described_class.perform(uri: 'https://foo/bar'))
      .to be_instance_of(Faraday::Response)
    end
  end
end
