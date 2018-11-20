# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BrainzProxy do
  let(:proxy) { described_class.new }
  let(:uri) do
    'https://musicbrainz.org/ws/2/release/' \
      '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a' \
      '?inc=artists+labels+recordings+release-groups'
  end

  describe '.last_request' do
    it 'is initial set to 0' do
      expect(described_class.last_request).to be(0)
    end
  end

  describe '#last_request' do
    it 'is initial set to 0' do
      expect(proxy.last_request).to be(0)
    end
  end

  describe '#get' do
    it 'returns a Brainz blueprint' do
      expect(proxy.get(uri)).to be_instance_of BrainzBlueprint
    end
  end
end
