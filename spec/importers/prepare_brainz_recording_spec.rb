# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'test_data'
require 'test_data/brainz_service'

RSpec.describe PrepareBrainzRecording do
  context 'when the recording does not exist in the database' do
    let(:stub) do
      TestData.by_name(:brainz_recording_highway_to_hell).blueprint
    end

    let(:proxy) { FakeProxy.new }

    before do
      described_class.call(
        import_order: MockImportOrder.new,
        proxy:        proxy,
        stub:         stub
      )
    end

    it 'requests the recording from the proxy' do
      expect(proxy.matches(%r{/recording/})).to eq(1)
    end

    it 'requests the artist from the proxy' do
      expect(proxy.matches(%r{/artist/})).to eq(1)
    end
  end

  context 'with "The Duellists"' do
    let(:stub) do
      TestData.by_name(:brainz_recording_the_duellists).blueprint
    end

    let(:proxy) { FakeProxy.new }

    it 'prepares the artist' do
      allow(PrepareBrainzArtistCredit).to receive(:call)

      described_class.call(
        import_order: MockImportOrder.new,
        proxy:        proxy,
        stub:         stub
      )

      expect(proxy.matches(%r{/recording/})).to eq(1)
    end
  end
end
