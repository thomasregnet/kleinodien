# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BrainzDataFetcher do
  let(:fetcher) { described_class.new }

  describe '.last_request' do
    it 'is initial set to 0' do
      expect(described_class.last_request).to be(0)
    end
  end

  describe '#last_request' do
    it 'is initial set to 0' do
      expect(fetcher.last_request).to be(0)
    end
  end

  describe '#get' do
    it 'returns a Brainz blueprint' do
      expect(fetcher.get(:foo)).to be_instance_of BrainzReleaseBlueprint
    end
  end
end
