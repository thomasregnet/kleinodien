require 'rails_helper'

RSpec.describe ImportConnection do
  describe '.redis' do
    it 'returns a redis connection' do
      expect(described_class.redis).to be_instance_of(Redis)
    end
  end

  describe '.uri' do
    it 'returns the redis uri' do
      expect(described_class.uri).to match(%r{^redis://[a-z]+})
    end
  end
end
